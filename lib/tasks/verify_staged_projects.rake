require 'json'

desc 'Say hello!'
task verify_staged_projects: [:environment] do
  staging_verifier = StagingVerifier.new()
  staging_verifier.verify_staging_directory
end

class StagingVerifier
  FILENAME_EXTRACTOR_REGEX = /.*\/(?<filename>.*\.json)/

  def initialize
    @errors = []
    @valid_files = []
    @successful_moves = []
  end

  def verify_staging_directory
    filepaths = load_json_files_from_staging_directory

    filepaths.each do |filepath|
      verify_json_contents(filepath)
    end

    if @valid_files.any?
      move_valid_files
    end

    report_results
  end

  private

  def load_json_files_from_staging_directory
    Dir.glob('json/staged_json/**/*').filter_map { |path| File.expand_path(path) if File.file?(path) }
  end

  def load_file(filepath)
    file = File.read(filepath)
    JSON.parse(file)
  end

  def verify_json_contents(filepath)
    begin
      contents = load_file(filepath)

      submission = Submission::SubmissionPackage.new(
        action: 'create_download',
        project_as_hash: {
          department: contents['department']&.downcase,
          video_link: contents['video_link'],
          title: contents['title'],
          abstract: contents['abstract'],
          year: contents['year']
        },
        people_as_array: contents['group_members']
      )

      unless submission.valid_submission?
        raise ActiveRecord::RecordInvalid.new(submission.error_messages_as_string)
      end

      @valid_files.append(filepath)
    rescue JSON::ParserError
      @errors.append({ filepath: filepath, message: 'Invalid json file.' })
    rescue ActiveRecord::RecordInvalid => error
      @errors.append({ filepath: filepath, message: error })
    rescue => error
      @errors.append({ filepath: filepath, message: 'Unknown error with file.' })
    end
  end

  def move_valid_files
    folder_name = SecureRandom.uuid

    begin
      Dir.mkdir("json/autogenerated_stage/#{folder_name}")
    rescue => error
      puts "Something went wrong with directory creation in json/autogenerated_stage. Error: #{error}"
      return false
    end

    @valid_files.each do |file|
      begin
        match = file.match(FILENAME_EXTRACTOR_REGEX)
        raise NameError.new("File name is a duplicate.") unless match

        filename = match['filename']
        target = "json/autogenerated_stage/#{folder_name}/#{filename}"

        raise NameError.new("File name is a duplicate.") if File.exist?(target)  

        File.rename file, target
        @successful_moves.append(file)
      rescue => error
        puts "Something went wrong moving #{file}."
        @errors.append({ filepath: file, message: "Moving Error. #{error}" })
      end
    end
  end

  def report_results
    puts "\n*********************\nResults Report: \n*********************\n"

    puts "\nSuccessfully Validated and Moved:\n*********************\n" if @successful_moves.any?
    @successful_moves.each do |success|
      puts success
    end

    puts "\nExperianced errors with:\n*********************\n" if @errors.any?
    @errors.each do |error|
      puts "#{error[:filepath]}: #{error[:message]}"
    end

    puts "\n*********************\n"
  end
end

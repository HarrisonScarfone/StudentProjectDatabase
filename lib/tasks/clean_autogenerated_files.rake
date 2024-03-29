# frozen_string_literal: true

desc 'Add all verified autogenerated files to the db.'
task clean_autogenerated_files: [:environment] do
  staging_verifier = FileCleaner.new
  puts staging_verifier.execute
end

class FileCleaner
  FILENAME_EXTRACTOR_REGEX = %r{.*/(?<filename>.*\.json)}.freeze

  def initialize
    @successful_files = []
    @successful_dirs = []
    @errors = []
  end

  def execute
    move_files
    clean_directories
    report_results
  end

  private

  def move_files
    folder_name = Time.zone.now.to_s.gsub(' ', '-')

    files = load_json_files_from_autogenerated_staged_directory

    begin
      Dir.mkdir("json/live_json/#{folder_name}") if files.any?
    rescue StandardError => e
      puts "Something went wrong with directory creation in json/live_json. Error: #{e}"
      return
    end

    files.each do |file|
      match = file.match(FILENAME_EXTRACTOR_REGEX)
      raise NameError, 'Filepath failed to allow a valid filename extraction.' unless match

      filename = match['filename']
      target = "json/live_json/#{folder_name}/#{filename}"

      raise NameError, 'File name is a duplicate.' if File.exist?(target)

      File.rename file, target
      @successful_files.append(file)
    rescue StandardError => e
      puts "Something went wrong moving #{file}."
      @errors.append({ filepath: file, message: "Moving Error. #{e}" })
    end
  end

  def load_json_files_from_autogenerated_staged_directory
    Dir.glob('json/autogenerated_staged/**/*').filter_map { |path| File.expand_path(path) if File.file?(path) }
  end

  def clean_directories
    directories = load_directories_for_deletion

    directories.each do |directory|
      Dir.rmdir(directory)
      @successful_dirs.append(directory)
    rescue StandardError => e
      puts "Unable to clean directory #{directory}. Error: #{e}"
      @errors.append({ directory: directory, message: e })
    end
  end

  def load_directories_for_deletion
    Dir.glob('json/autogenerated_staged/**/*').filter_map { |dir| File.expand_path(dir) if File.directory?(dir) }
  end

  def report_results
    puts "\n*********************\nResults Report: \n*********************\n"

    if @successful_files.any? || @successful_dirs.any?
      puts "\nFinalized #{@successful_files.count} files from #{@successful_dirs.count} directory.\n"
    end

    puts "\nDeleted directories with names: #{@successful_dirs}" if @successful_dirs.any?

    puts "\n#{@errors.count} directories experianced errors:\n*********************\n" if @errors.any?

    @errors.each do |error|
      puts "#{error[:directory]}: #{error[:message]}"
    end

    puts "\nNothing to do.\n" if @errors.empty? && @successful_dirs.empty? && @successful_files.empty?

    puts "\n*********************\n"
  end
end

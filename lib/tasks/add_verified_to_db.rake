# frozen_string_literal: true

require 'json'

desc 'Add all verified autogenerated files to the db.'
task add_verified_to_db: [:environment] do
  staging_verifier = ProjectFinalizer.new
  staging_verifier.execute
end

class ProjectFinalizer
  def initialize
    @errors = []
    @successful = []
  end

  def execute
    filepaths = load_verified_json_files

    filepaths.each do |filepath|
      create_database_entry(filepath)
    end

    report_results
  end

  private

  def create_database_entry(filepath)
    json_contents = load_file(filepath)

    ActiveRecord::Base.transaction do
      project = Project.create(
        title: json_contents['title'],
        year: json_contents['year'],
        department: json_contents['department'],
        video_link: json_contents['video_link'],
        abstract: json_contents['abstract']
      )

      json_contents['group_members'].each do |person|
        Person.create(
          name: person,
          project_id: project.id
        )
      end

      @successful.append(project.id)
    end
  rescue StandardError => e
    @errors.append({ filepath: filepath, message: e })
  end

  def report_results
    puts "\n*********************\nResults Report: \n*********************\n"

    puts "\n#{@successful.count} file(s) successfully created records!\n*********************\n" if @successful.any?
    puts "\nWrote new project records with ids: #{@successful}.\n" if @successful.any?

    puts "\n#{@errors.count} files experianced errors:\n*********************\n" if @errors.any?

    @errors.each do |error|
      puts "#{error[:filepath]}: #{error[:message]}"
    end

    puts "\nNothing to do.\n" if @errors.empty? && @successful.empty?

    puts "\n*********************\n"
  end

  def load_verified_json_files
    Dir.glob('json/autogenerated_staged/**/*').filter_map { |path| File.expand_path(path) if File.file?(path) }
  end

  def load_file(filepath)
    file = File.read(filepath)
    JSON.parse(file)
  end
end

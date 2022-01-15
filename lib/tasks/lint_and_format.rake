# frozen_string_literal: true

NAMED_DIRECTORIES = [
  './app',
  './config',
  './db',
  './lib',
  './test',
  'Gemfile'
].freeze

desc 'Recursively run linting and formatting on directories named in rake task.'
task :lint_and_format, [:disableAutocorrect] do |_, args|
  overall = []
  NAMED_DIRECTORIES.each do |dir|
    result =
      if args[:disableAutocorrect] == 'disableautocorrect'
        `rubocop #{dir}`
      else
        `rubocop #{dir} --auto-correct-all`
      end

    overall.append(result)
  end

  puts overall
  puts "\n"

  return 1 if overall.join.include?('Offenses:')
end

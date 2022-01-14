# frozen_string_literal: true

NAMED_DIRECTORIES = [
  './app',
  './config',
  './db',
  './lib',
  './test'
].freeze

desc 'Recursively run linting and formatting on directories named in rake task.'
task :lint_and_format do
  overall = []
  NAMED_DIRECTORIES.each do |dir|
    result = `rubocop #{dir} --auto-correct-all`
    overall.append(result)
  end

  puts overall
  puts "\n"
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # setup factorybot
  include FactoryBot::Syntax::Methods
end

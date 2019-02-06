require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest'
require 'minitest/autorun'
require 'minitest/ci'

if ENV['CIRCLECI']
  Minitest::Ci.report_dir = "#{ENV['CIRCLE_TEST_REPORTS']}/reports"
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

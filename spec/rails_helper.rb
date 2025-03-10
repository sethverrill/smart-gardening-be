# if defined?(ActiveRecord::FixtureSet::MAX_ID)
#   Object.send(:remove_const, 'ActiveRecord::FixtureSet::MAX_ID')
# end

require 'shoulda/matchers'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join('spec/fixtures')
  ]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end

  VCR.configure do |config|
    config.cassette_library_dir = 'spec/cassettes'
    config.hook_into :webmock
    config.filter_sensitive_data('<API_KEY>') { ENV['OPENAI_API_KEY'] }
    config.default_cassette_options = { re_record_interval: nil }
    config.configure_rspec_metadata!
    config.allow_http_connections_when_no_cassette = true
  end


require 'simplecov'
# SimpleCov.start 'rails' do
#   add_filter '/spec/'
# end
SimpleCov.start
require 'webmock/rspec'
require 'vcr'
require 'factory_bot'


require 'pry'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.filter_run_when_matching :focus
  config.order = :random
  config.color = true
  config.tty = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.add_formatter Fuubar if defined?(Fuubar)
  Kernel.srand config.seed
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = false
end

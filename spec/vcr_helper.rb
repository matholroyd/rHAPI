require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/spec"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.ignore_localhost = true
  config.default_cassette_options = {
    record: :once
  }
  
  config.ignore_request do |request|
    request.headers.include?("Referer")
  end
end


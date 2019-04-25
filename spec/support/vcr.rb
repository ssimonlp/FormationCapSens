# frozen_string_literal: true

# spec/support/vcr.rb
VCR.configure do |config|
  config.ignore_localhost = true
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data("") { ENV['mangopay_client_id'] }
  config.filter_sensitive_data("") { ENV['mangopay_client_passphrase'] }
end

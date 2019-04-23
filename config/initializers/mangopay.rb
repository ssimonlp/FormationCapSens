MangoPay.configure do |c|
  c.preproduction = true
  c.client_id = ENV['mangopay_client_id']
  c.client_passphrase = ENV['mangopay_api_key']
end


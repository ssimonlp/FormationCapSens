MangoPay.configure do |c|
  c.preproduction = true
  c.client_id = Rails.application.credentials.mangopay_client_id
  c.client_passphrase = Rails.application.credentials.mangopay_api_key
end


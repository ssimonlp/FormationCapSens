# frozen_string_literal: true

require "dry/transaction"

class User::CreateTransaction
  include Dry::Transaction

  tee :params
  step :new
  step :mangopay_user
  tee :save
  step :mangopay_wallet
  tee :notify

  def params(input)
    @params = input.fetch(:params)
  end

  def new(input)
    @user = User.new(@params)
    if @user.valid?
      Success(input)
    else
      Failure(input.merge(errors: @user.errors.full_messages.join(', ')))
    end
  end

  def mangopay_user(input)
    response = MangoPay::NaturalUser.create(mangopay_params)
    if response['Id']
      Success(input.merge(mangopay_id: response['Id']))
    else
      Failure(input)
    end
  rescue MangoPay::ResponseError => e
    Failure(input.merge(errors: e.errors.to_a.join(": ")))
  end

  def save(input)
    @user.profile.mangopay_id = input[:mangopay_id]
    @user.skip_confirmation_notification!
    @user.save
  end

  def mangopay_wallet(input)
    response = MangoPay::Wallet.create(Owners: [input[:mangopay_id]], Currency: 'EUR', Description: "Test wallet")
    if response['Id']
      @user.profile.update(mangopay_wallet_id: response['Id'])
      Success(input)
    else
      Failure(input)
    end
  rescue MangoPay::ResponseError => e
    Failure(input.merge(errors: e.errors.to_a.join(": ")))
  end

  def notify(_input)
    @user.send_confirmation_instructions
  end

  private

  def mangopay_params
    {
      FirstName: @user.profile.first_name,
      LastName: @user.profile.last_name,
      Address: {
        AddressLine1: @user.profile.address_line1,
        AddressLine2: @user.profile.address_line2,
        City: @user.profile.city,
        Region: @user.profile.region,
        PostalCode: @user.profile.postal_code,
        Country: @user.profile.country
      },
      Birthday: @user.profile.date_of_birth.to_time.to_i,
      Nationality: @user.profile.nationality,
      CountryOfResidence: @user.profile.country_of_residence,
      Occupation: @user.profile.occupation,
      IncomeRange: @user.profile.income_range,
      Email: @user.email
    }
  end
end

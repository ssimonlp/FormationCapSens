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

  def save(_input)
    @user.profile.mangopay_id = _input[:mangopay_id]
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
      FirstName: @params[:profile_attributes][:first_name],
      LastName: @params[:profile_attributes][:last_name],
      Address: {
        AddressLine1: @params[:profile_attributes][:address_line1],
        AddressLine2: @params[:profile_attributes][:address_line2],
        City: @params[:profile_attributes][:city],
        Region: @params[:profile_attributes][:region],
        PostalCode: @params[:profile_attributes][:postal_code],
        Country: @params[:profile_attributes][:country]
      },
      Birthday: flatten_date_array(@params[:profile_attributes]),
      Nationality: @params[:profile_attributes][:nationality],
      CountryOfResidence: @params[:profile_attributes][:country_of_residence],
      Occupation: @params[:profile_attributes][:occupation],
      IncomeRange: @params[:profile_attributes][:income_range],
      Email: @params[:email]
    }
  end

  def flatten_date_array(hash)
    Date.parse(%w(3 2 1).map { |e| hash["date_of_birth(#{e}i)"].to_s }.join('-')).to_time.to_i
  end
end

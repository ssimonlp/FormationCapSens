# frozen_string_literal: true

require "dry/transaction"

class User::CreateTransaction
  include Dry::Transaction

  tee :init
  step :create
  tee :notify

  def init(input)
    @email = input[:email]
    @password = input[:password]
    @first_name = input[:profile_attributes][:first_name]
    @last_name = input[:profile_attributes][:last_name]
    @date_of_birth = input[:profile_attributes][:date_of_birth]
  end

  def create(input)
    @user = User.new(email: @email, password: @password, profile_attributes: { first_name: @first_name, last_name: @last_name, date_of_birth: @date_of_birth })
    if @user.valid?
      @user.save!
      Success(input)
    else
      Failure(input.merge(errors: @user.errors.messages))
    end
  end

  def notify(input)
    @user.send_confirmation_instructions
  end
end

# frozen_string_literal: true

require "dry/transaction"

class User::CreateTransaction
  include Dry::Transaction

  tee :params
  step :new
  tee :save
  tee :notify
  
  def params(input)
    @params = input.fetch(:params)
  end
  
  def new(input)
    @user = User.new(@params)
    if @user.valid?
      Success(input)
    else
      Failure(input.merge(errors: @user.errors.messages))
    end
  end

  def save(input)
      @user.skip_confirmation!
      @user.save
  end

  def notify(input)
    @user.send_confirmation_instructions
  end
end

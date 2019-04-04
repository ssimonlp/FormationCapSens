# frozen_string_literal: true

require "dry/transaction"

class User::CreateTransaction
  include Dry::Transaction

  tee :params
  step :new
  tee :create
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

  def create(input)
      @user.save!
  end

  def notify(input)
    @user.send_confirmation_instructions
  end
end

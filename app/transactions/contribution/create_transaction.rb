# frozen_string_literal: true

require 'dry/transaction'

class Contribution::CreateTransaction
  include Dry::Transaction

  tee :params
  tee :set_value
  step :new
  tee :save

  def params(input)
    @contribution = input.fetch(:params)
  end

  def set_value(_input)
    @contribution.value = @contribution.counterpart.price
  end

  def new(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge(errors: @contribution.errors.full_messages.join(', ')))
    end
  end

  def save(_input)
    @contribution.save
  end
end

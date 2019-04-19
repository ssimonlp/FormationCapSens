# frozen_string_literal: true

require 'dry/transaction'

class Contribution::CreateTransaction
  include Dry::Transaction

  tee :params
  tee :set_value
  step :new
  tee :save

  def params(input)
    @contribution = input
  end

  def set_value(_input)
    @value = @contribution.counterpart.price
    @contribution.update(value: @value)
  end

  def new(input)
    if @contribution.valid?
      Success(input)
    else
      Failure(input)
    end
  end

  def save(_input)
    @contribution.save
  end
end

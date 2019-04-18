# frozen_string_literal: true

require 'dry/transaction'

class Contribution::CreateTransaction
  include Dry::Transaction

  tee :params
  step :new
  tee :save

  def params(input)
    @params = input.fetch(:params)
    @project_id = @params[:id]
    @counterpart = Counterpart.find(@params[:project][:counterparts])
    @user_id = @params[:user_id]
    @value = @counterpart.price
  end

  def new(input)
    @contribution = Contribution.new(user_id: @user_id, project_id: @project_id, counterpart_id: @counterpart.id, value: @value )
    if @contribution.valid?
      Success(input)
    else
      Failure(input.merge(errors: @contribution.errors.full_messages.join(', '), resource: @contribution))
    end
  end

  def save(_input)
    @contribution.save
  end
end


# frozen_string_literal: true

require 'dry/transaction'

class Project::CreateTransaction
  include Dry::Transaction

  tee :params
  step :new
  tee :save

  def params(input)
    @params = input.fetch(:params)[:project]
  end

  def new(input)
    @project = Project.new(@params)
    if @project.valid?

      Success(input)
    else
      Failure(input.merge(errors: @project.errors.full_messages.join(', '), resource: @project))
    end
  end

  def save(_input)
    @project.save
    @project.start_upcoming! if @project.can_upcome?
  end
end

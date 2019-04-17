# frozen_string_literal: true

require 'dry/transaction'

class Counterpart::CreateTransaction
  include Dry::Transaction

  tee :params
  step :ongoing?
  step :new
  tee :save

  def params(input)
    @params = input.fetch(:params)[:counterpart]
  end

  def ongoing?(input)
    @project = Project.find(@params[:project_id])
    if @project.ongoing? || @project.success? || @project.failure?
      Failure(input.merge(errors: "You can't add new counterparts to this project."))
    else
      Success(input)
    end
  end

  def new(input)
    @counterpart = Counterpart.new(@params)
    if @counterpart.valid?
      Success(input)
    else
      Failure(input.merge(errors: @counterpart.errors.messages))
    end
  end

  def save(_input)
    @counterpart.save
    @project.start_ongoing! if @project.can_ongo?
  end
end

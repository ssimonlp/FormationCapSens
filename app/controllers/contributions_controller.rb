# frozen_string_literal: true

class ContributionsController < ApplicationController
  def create
    @contribution = current_user.contributions.new(contribution_params)
    create_contribution = Contribution::CreateTransaction.new.call(params: @contribution)
    if create_contribution.success?
      flash[:notice] = "Contribution was successfully created."
      redirect_to create_contribution.success[:redirection]
    else
      flash[:alert] = create_contribution.failure[:errors]
      redirect_to projects_path
    end
  end

  protected

  def contribution_params
    params.require(:contribution).permit(:project_id, :counterpart_id)
  end
end

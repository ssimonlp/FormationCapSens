class ContributionsController < ApplicationController
  def create
    create_contribution = Contribution::CreateTransaction.new.call(params: params.merge(user_id: current_user.id))
    if create_contribution.success?
      flash[:notice] = "Contribution was successfully created."
      redirect_to projects_path
    else
      @contribution = create_contribution.failure[:resource]
      flash[:alert] = create_contribution.failure[:errors]
      redirect_to project_path(params[:id])
    end
  end
end

# frozen_string_literal: true

module OnlyUsers
  extend ActiveSupport::Concern
  included do
    before_action :check_users
  end

  protected

  def check_users
    unless current_user
      flash[:alert] = "You must sign in to visit this page"
      redirect_to(root_path) && return
    end
  end
end

# frozen_string_literal: true

module UsersHelper
  def user_state(user)
    if user_signed_in?
      "Bienvenue #{user.profile.first_name} #{user.profile.last_name}"
    else
      "Bienvenue visiteur "
    end
  end
end

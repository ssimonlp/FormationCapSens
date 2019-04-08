# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    authenticate_user!
  end
end

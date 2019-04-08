# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response.status).to eq(302)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do
  let(:category) { create(:category) }

  let(:valid_attributes) do
    attributes_for(:project, category_id: category.id)
  end

  let(:invalid_attributes) do
    attributes_for(:invalid_project)
  end

  before(:each) do
    sign_in FactoryBot.create(:admin_user)
  end

  describe "GET index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it 'creates the project with the right attributes' do
        post :create, params: { project: valid_attributes }
        project = Project.last

        expect(project.name).to eq(valid_attributes[:name])
        expect(project.goal).to eq(valid_attributes[:goal].to_f)
        expect(project.category_id).to eq(valid_attributes[:category_id])
      end
    end

    context "with invalid attributes" do
      it "doesn't create a new Project" do
        expect {
          post :create, params: { project: invalid_attributes }
        }.not_to change(Project, :count)
      end
    end
  end
end

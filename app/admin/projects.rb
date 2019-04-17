# frozen_string_literal: true

ActiveAdmin.register Project do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  menu priority: 2

  decorate_with ProjectDecorator

  permit_params :name,
                :short_description,
                :long_description,
                :goal,
                :image,
                :category_id,
                counterparts_attributes: %i[id name price description stock project_id]

  index do
    selectable_column
    id_column
    column "Image" do |project|
      project.image.present? ? (image_tag project.image_url(:thumb)) : "No image available yet."
    end
    column :name
    column :short_description
    column :goal
    column :created_at
    actions
  end

  filter :name, as: :string
  filter :goal, as: :numeric
  filter :created_at, as: :date_range
  filter :category, label: 'Category', as: :select,
                    collection: proc { Category.distinct.pluck :name, :id }

  action_item :new_counterpart, only: :show do
    link_to 'New Counterpart', new_admin_counterpart_path(project_id: project.id) unless project.ongoing? || project.success? || project.failure?
  end

  show do
    attributes_table do
      row :name
      row :short_description
      row :long_description
      row :goal
      row :category do |project|
        project.category.name
      end
      row :collected
      row :progress
      row :highest
      row :lowest
      row "Image" do |project|
        project.image.present? ? (image_tag project.image_url(:landscape)) : "No image available yet."
      end
    end
    panel "Contributions" do
      attributes_table_for project.contributions do
        row "Contributors" do |c|
          link_to c.contributor, admin_user_path(c.user)
        end
        row "Amount" do |c|
          "#{c.value}$"
        end
        row "Counterpart" do |c|
          link_to c.counterpart.name, admin_counterpart_path(c.counterpart)
        end
        row "Date", &:created_at
      end
    end
    panel "Counterparts" do
      attributes_table_for project.counterparts do
        row "Type" do |ct|
          link_to ct.name, admin_counterpart_path(ct)
        end
        row "Price", &:price
        row "Stock", &:stock
        row "Actions" do |ct|
          span link_to "Edit", edit_admin_counterpart_path(ct)
          span link_to "Delete", admin_counterpart_path(ct), method: :delete
        end
      end
    end
  end

  controller do
    def create
      create_project = Project::CreateTransaction.new.call(params: permitted_params)
      if create_project.success?
        flash[:notice] = "Project was successfully created."
        redirect_to admin_projects_path
      else
        error = create_project.failure[:errors]
        flash[:alert] = error.class == String ? error : error.first.flatten[0..1].join(" ").capitalize
        puts permitted_params[:project]
        puts "--------------------"
        redirect_to new_admin_project_path(permitted_params[:project])
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :goal, min: 0
      f.input :image, as: :file
      f.input :category
    end
    f.actions
  end
end

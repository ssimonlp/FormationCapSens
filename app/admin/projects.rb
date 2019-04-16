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
  decorate_with ProjectDecorator

  permit_params :name,
                :short_description,
                :long_description,
                :goal,
                :image,
                :category_id

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
        row "Counterpart", &:counterpart_chosen
        row "Date", &:created_at
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :short_description
      f.input :long_description
      f.input :goal
      f.input :image, as: :file
      f.input :category
    end
    f.actions
  end
end

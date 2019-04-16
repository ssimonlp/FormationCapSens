# frozen_string_literal: true

ActiveAdmin.register Category do
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

  menu priority: 3

  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  filter :name, as: :string
  filter :created_at, as: :date_range
  filter :updated_at, as: :date_range

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end
end

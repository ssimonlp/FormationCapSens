# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :last_sign_in_at
    actions
  end

  filter :email
  filter :created_at
  filter :last_sign_in_at

  form do |f|
    f.inputs do
      unless !f.object.new_record?
        f.input :email
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end

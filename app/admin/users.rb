# frozen_string_literal: true

ActiveAdmin.register User do
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

  permit_params :email,
                :password,
                :password_confirmation,
                profile_attributes: %i[id first_name last_name date_of_birth]

  index do
    selectable_column
    id_column
    column :email
    column :last_name do |user|
      user.profile.last_name
    end
    column :first_name do |user|
      user.profile.first_name
    end
    column :created_at
    column :updated_at
    column :sign_in_count
    column :last_sign_in_at
    column :last_sign_in_ip
    actions
  end

  filter :email
  filter :profile_last_name, as: :string
  filter :profile_first_name, as: :string
  filter :created_at, as: :date_range
  filter :last_sign_in, as: :date_range
  filter :sign_in_count, as: :numeric

  show do
    attributes_table do
      row :email
      row :encrypted_password
      row :last_name do |user|
        user.profile.last_name
      end
      row :first_name do |user|
        user.profile.first_name
      end
      row :date_of_birth do |user|
        user.profile.date_of_birth
      end
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row :login_as do
        link_to user.profile.first_name, login_as_admin_user_path(user), target: '_blank', rel: 'noopener'
      end
    end
  end

  controller do
    def update
      @user = resource
      if params[:user][:password].blank?
        @user.update_without_password(permitted_params[:user])
      else
        @user.update(permitted_params[:user])
      end
      if @user.valid?
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit
      end
    end
  end

  member_action :login_as, method: :get do
    @user = resource
    bypass_sign_in @user
    redirect_to my_dashboard_path(@user)
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.inputs for: [:profile, (f.object.profile || f.object.build_profile)] do |p|
      p.input :last_name
      p.input :first_name
      p.input :date_of_birth
    end
    f.actions
  end
end

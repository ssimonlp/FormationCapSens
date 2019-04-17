# frozen_string_literal: true

ActiveAdmin.register Counterpart do
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
  menu priority: 4

  permit_params :counterpart,
                :name,
                :price,
                :description,
                :stock,
                :project_id

  controller do
    def create
      create_counterpart = Counterpart::CreateTransaction.new.call(params: permitted_params)
      if create_counterpart.success?
        flash[:notice] = "Counterpart was successfully created."
        redirect_to admin_counterparts_path
      else
        error = create_counterpart.failure[:errors]
        flash[:alert] = error.class == String ? error : error.first.flatten[0..1].join(" ").capitalize
        redirect_to new_admin_counterpart_path(permitted_params[:counterpart])
      end
    end
  end

  form do |f|
    f.inputs do
      if f.object.new_record?
        f.input :project, collection: Project.pre_ongoing.pluck(:name, :id), selected: (f.object.project_id || params[:project_id])
      else
        f.input :project, collection: Project.pluck(:name, :id), selected: (f.object.project_id || params[:project_id])
      end
      f.input :name
      f.input :price, min: 1
      f.input :description
      f.input :stock, min: 0
    end
    f.actions
  end
end

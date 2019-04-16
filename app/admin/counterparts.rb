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

  permit_params :name,
                :price,
                :description,
                :stock,
                :project_id

  form do |f|
    f.inputs do
      f.input :project_id, input_html: { value: params[:project_id] }
      f.input :name
      f.input :price, min: 1
      f.input :description
      f.input :stock, min: 0
    end
    f.actions
  end
end

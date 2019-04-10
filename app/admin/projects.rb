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
  permit_params :name,
                :short_description,
                :long_description,
                :goal,
                :image_data,
                :category_id
  
  index do
    selectable_column
    id_column
    column :name
    column :short_description
    column :goal
    column "Image" do |project|
      image_tag project.image_url(:thumb)
    end
    column :category_id
    actions
  end

  filter :name, as: :string
  filter :goal, as: :numeric
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
    end
  end
end

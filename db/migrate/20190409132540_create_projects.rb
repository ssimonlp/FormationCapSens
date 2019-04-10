class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :short_description
      t.text :long_description
      t.float :goal
      t.string :image_data
      t.belongs_to :category, index: true
      t.timestamps
    end
  end
end

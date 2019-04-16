# frozen_string_literal: true

class CreateCounterparts < ActiveRecord::Migration[5.2]
  def change
    create_table :counterparts do |t|
      t.string :name
      t.text :description
      t.integer :stock
      t.belongs_to :project
      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country
      t.string :nationality
      t.string :country_of_residence
      t.string :occupation
      t.integer :income_range
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: counterparts
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  price       :float
#  description :text
#  stock       :integer
#  project_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Counterpart < ApplicationRecord
  belongs_to :project
  has_many :contributions, dependent: :destroy

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true
end

# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :projects, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

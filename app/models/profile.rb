# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :last_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :date_of_birth, presence: true
end

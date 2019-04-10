# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id              :bigint(8)        not null, primary key
#  first_name      :string
#  last_name       :string
#  date_of_birth   :date
#  registration_ip :inet
#  user_id         :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :last_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :date_of_birth, presence: true
end

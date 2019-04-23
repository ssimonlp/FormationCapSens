# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id                   :bigint(8)        not null, primary key
#  first_name           :string
#  last_name            :string
#  date_of_birth        :date
#  address_line1        :string
#  address_line2        :string
#  city                 :string
#  region               :string
#  postal_code          :string
#  country              :string
#  nationality          :string
#  country_of_residence :string
#  occupation           :string
#  income_range         :integer
#  user_id              :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Profile < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :last_name, presence: true, format: { with: /\A[[:alpha:]]+([\-\' ][[:alpha:]]+)*\z/ }
  validates :date_of_birth, presence: true
end

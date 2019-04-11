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

FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(18, 65) }

    trait :missing_first_name do
      first_name { "" }
    end

    factory :wrong_profile, traits: %i[missing_first_name]
  end
end

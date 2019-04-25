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
#  mangopay_id          :bigint(8)
#  mangopay_wallet_id   :bigint(8)
#  user_id              :bigint(8)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

FactoryBot.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(18, 65) }
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    region { Faker::Address.state }
    postal_code { "75010" }
    country_of_residence { Faker::Address.country_code }
    nationality { Faker::Address.country_code }
    country { Faker::Address.country_code }
    occupation { "worker" }
    income_range { 2 }
    mangopay_id { 64_361_581 }
    mangopay_wallet_id { 64_361_582 }

    trait :missing_first_name do
      first_name { "" }
    end

    factory :wrong_profile, traits: %i[missing_first_name]
  end
end

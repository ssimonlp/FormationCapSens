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

FactoryBot.define do
  factory :counterpart do
    name { Faker::Appliance.equipment }
    description { Faker::TvShows::MichaelScott.quote }
    price { rand(10..500) }
    stock { rand(1..100) }
    association :project, factory: :project
  end
end

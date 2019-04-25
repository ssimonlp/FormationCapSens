# frozen_string_literal: true

# == Schema Information
#
# Table name: contributions
#
#  id             :bigint(8)        not null, primary key
#  value          :float
#  user_id        :bigint(8)
#  project_id     :bigint(8)
#  counterpart_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :contribution do
    value { Faker::Number.between(1, 1000) }
    association :user, factory: :confirmed_user
    project

    trait :with_counterpart do
      counterpart
    end

    trait :wrong_value do
      value { "" }
    end

    factory :wrong_contribution, traits: %i[wrong_value with_counterpart]
    factory :complete_contribution, traits: %i[with_counterpart]
  end
end

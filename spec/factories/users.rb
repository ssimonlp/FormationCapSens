# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 10) }
    association :profile, strategy: :build

    transient do
      project  Project.find(Kernel.rand(Project.first.id..Project.last.id))
    end

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end

    trait :wrong_email do
      email { "hey" }
    end
    
    trait :with_contributions do
      after :create do |user, evaluator|
        user.contributions << create_list(:complete_contribution, 5, user: user, project: evaluator.project, counterpart: evaluator.project.counterparts.sample)
      end
    end

    factory :confirmed_user, traits: %i[confirmed]
    factory :wrong_user, traits: %i[wrong_email confirmed]
    factory :contributing_user, traits: %i[confirmed with_contributions]
  end
end

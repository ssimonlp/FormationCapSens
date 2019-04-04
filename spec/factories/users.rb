FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 10) }
    association :profile, strategy: :build

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end

    trait :wrong_email do
      email { "hey" }
    end

    factory :confirmed_user, traits: %i[confirmed]
    factory :wrong_user, traits: %i[wrong_email confirmed]
  end
end

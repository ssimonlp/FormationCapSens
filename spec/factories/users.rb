FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(8, 10) }

    trait :confirmed do
      confirmed_at { Time.zone.now }
    end

    factory :user_confirmed, traits: %i[confirmed]
  end
end

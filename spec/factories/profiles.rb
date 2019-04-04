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

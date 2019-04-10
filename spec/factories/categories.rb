FactoryBot.define do
  factory :category do
    name { Faker::TvShows::GameOfThrones.house }
  end
end

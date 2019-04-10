FactoryBot.define do
  factory :project do
    name { Faker::TvShows::SiliconValley.company }
    short_description { Faker::TvShows::MichaelScott.quote }
    long_description { Faker::Lorem.paragraph(10) }
    goal { Faker::Number.number(6) }
    image_data { open(Dir[Rails.root.join('spec', 'fixtures', 'images', '*')].sample) }
    category_id { rand(Category.first.id..Category.last.id) }
  end
end

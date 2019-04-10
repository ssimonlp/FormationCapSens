# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id                :bigint(8)        not null, primary key
#  name              :string
#  short_description :text
#  long_description  :text
#  goal              :float
#  image_data        :text
#  category_id       :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#


FactoryBot.define do
  factory :project do
    name { Faker::TvShows::SiliconValley.unique.company }
    short_description { Faker::TvShows::MichaelScott.quote }
    long_description { Faker::Lorem.paragraph(10) }
    goal { Faker::Number.number(6) }
    image { open(Dir[Rails.root.join('spec', 'fixtures', 'images', '*')].sample) }
    category
  end
end

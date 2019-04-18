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
#  aasm_state        :string
#

FactoryBot.define do
  factory :project do
    name { Faker::Device.unique.model_name }
    goal { Faker::Number.number(6) }
    category

    trait :image do
      image { open(Dir[Rails.root.join('spec', 'fixtures', 'images', '*')].sample) }
    end

    trait :short_description do
      short_description { Faker::Lorem.paragraph(3) }
    end

    trait :long_description do
      long_description { Faker::Lorem.paragraph(10) }
    end

    trait :missing_name do
      name { "" }
    end

    trait :with_counterparts do
      after :create do |project|
        project.counterparts << create_list(:counterpart, 5, project: project)
      end
    end
    factory :invalid_project, traits: %i[missing_name]
    factory :complete_project, traits: %i[image short_description long_description with_counterparts]
  end
end

# == Schema Information
#
# Table name: counterparts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  descrition :text
#  stock      :integer
#  project_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :counterpart do
  name { Faker::Appliance.unique.equipment }
    description { Faker::TvShows::MichaelScott.quote }
    stock { rand(100) + 1 }
    association :project, factory: :project
  end
end

# frozen_string_literal: true

require 'factory_bot_rails'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
AdminUser.destroy_all
Category.destroy_all
Project.destroy_all

# seed admin
puts "Seeding Admins..."
AdminUser.create(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# seed confirmed users/profiles
puts "Seeding confirmed users..."
FactoryBot.create_list(:confirmed_user, 20)

# seed unconfirmed users
#puts "seeding unconfirmed users..."
#5.times do |_i|
  #user_i = FactoryBot.build :user
  #user_i.skip_confirmation_notification!
  #user_i.save
#end

#seed categories
puts "seeding categories"
FactoryBot.create_list(:category, 10)

# seed projects
puts "seeding projects..."
20.times do
  FactoryBot.create(:complete_project, category: Category.all.sample)
end

#seed contributions
puts "seeding contributions..."
a  =*(User.all.first.id..User.all.last.id)
b =*(Project.all.first.id..Project.all.last.id)
combinations = a.product(b).sample(50)
combinations.each do |c|
  user = User.find(c[0])
  project = Project.find(c[1])
  counterpart = project.counterparts.sample
  FactoryBot.create(:complete_contribution, user: user, project: project, counterpart: counterpart)
end


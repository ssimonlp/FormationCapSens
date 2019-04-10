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
10.times do
  FactoryBot.create :confirmed_user
end

# seed unconfirmed users
puts "seeding unconfirmed users..."
5.times do |_i|
  user_i = FactoryBot.build :user
  user_i.skip_confirmation_notification!
  user_i.save
end

#seed categories
puts "seeding categories ..."
10.times do
  FactoryBot.create :category
end

#seed projects
puts "seeding projects..."
20.times do
  FactoryBot.create :project
end


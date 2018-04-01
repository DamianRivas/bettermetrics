require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
  user = User.new(
    email: Faker::Internet.unique.safe_email,
    password: 'helloworld',
    password_confirmation: 'helloworld'
  )
  user.save!
  user.confirm
end

users = User.all

20.times do
  domain = Faker::Internet.unique.domain_word
  RegisteredApplication.create!(
    name: domain,
    url: "#{domain}.com",
    user: users.sample
  )
end

apps = RegisteredApplication.all

10000.times do
  event = Event.create!(
    name: Faker::Hacker.verb,
    registered_application: apps.sample
  )
  event.created_at = (rand*10).days.ago
  event.save!
end

User.first.update({email: "drivas1993@gmail.com"})
Faker::UniqueGenerator.clear

puts "#{User.count} users created."
puts "#{RegisteredApplication.count} registered applications created."
puts "#{Event.count} events created."
require 'faker'

FactoryBot.define do
  factory :event do
    name Faker::Hacker.verb
    registered_application
  end
end

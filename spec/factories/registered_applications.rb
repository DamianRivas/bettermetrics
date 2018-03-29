FactoryBot.define do
  domain = Faker::Internet.domain_word

  factory :registered_application do
    name domain
    url "#{domain}.com"
    user
  end
end

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    google_id { Faker::Number.number(digits: 21) }
  end
end

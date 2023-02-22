FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    user_id { Faker::String.random(length: 8)}
  end
end

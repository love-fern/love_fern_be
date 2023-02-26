FactoryBot.define do
  factory :shelf do
    association :user
    name { Faker::Space.planet }
  end
end

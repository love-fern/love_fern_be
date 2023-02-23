FactoryBot.define do
  factory :shelf do
    name { Faker::Space.planet }
  end
end

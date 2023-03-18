FactoryBot.define do
  factory :shelf do
    association :user
    name { Faker::Lorem.unique.word }
  end
end

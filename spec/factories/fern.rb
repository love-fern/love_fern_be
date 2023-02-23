FactoryBot.define do
  factory :fern do
    name { Faker::Name.name }
    frequency { Faker::Number.between(from: 1, to: 10)}
  end
end


FactoryBot.define do
  factory :fern do
    name { Faker::Name.name }
    duration { Faker::Number.between(from: 1, to: 10)}
  end
end


FactoryBot.define do
  factory :fern do
    name { Faker::Name.name }
    duration { Faker::Number.between(from: 1, to: 10)}
    tag {Faker::Creature::Animal.name}
  end
end


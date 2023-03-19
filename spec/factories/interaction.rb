FactoryBot.define do
  factory :interaction do
    association :fern
    evaluation { Faker::Number.within(range: 0.0..1.0).round(1) }
    description { 'message' }
  end
end
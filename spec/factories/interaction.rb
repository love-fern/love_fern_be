FactoryBot.define do
  factory :interaction do
    association :fern
    evaluation { ["Positive", "Negative", "Neutral"].sample }
  end
end
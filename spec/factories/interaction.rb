FactoryBot.define do
  factory :interaction do
    association :fern
    evaluation { %w[Positive Negative Neutral].sample }
  end
end

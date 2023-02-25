FactoryBot.define do
  factory :interaction do
    evaluation { ["Positive", "Negative"].sample }
  end
end
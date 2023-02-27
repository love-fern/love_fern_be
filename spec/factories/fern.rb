FactoryBot.define do
  factory :fern do
    association :shelf
    name { Faker::Name.name }
    preferred_contact_method { ['text', 'email', 'mail'].sample }
  end
end


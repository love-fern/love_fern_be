FactoryBot.define do
  factory :fern do
    name { Faker::Name.name }
    preferred_contact_method { ['text', 'email', 'mail'].sample }
  end
end


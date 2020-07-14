FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Games::Dota.team }
  end
end

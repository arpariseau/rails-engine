FactoryBot.define do
  factory :customer, class: Customer do
    first_name { Faker::Games::ElderScrolls.first_name }
    last_name { Faker::Games::ElderScrolls.last_name }
  end
end

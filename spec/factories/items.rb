FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Games::Dota.item }
    description { Faker::TvShows::BojackHorseman.tongue_twister }
    unit_price { Faker::Commerce.price }
    association :merchant, factory: :merchant
  end
end

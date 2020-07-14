FactoryBot.define do
  factory :invoice, class: Invoice do
    status { "shipped" }
    association :customer, factory: :customer
    association :merchant, factory: :merchant
  end
end

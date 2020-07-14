FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    quantity { Faker::Number.non_zero_digit }
    unit_price { Faker::Commerce.price}
    association :invoice, factory: :invoice
    association :item, factory: :item
  end
end

FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { Faker::Number.decimal_part(digits: 16) }
    result { "success" }
    association :invoice, factory: :invoice
  end
end

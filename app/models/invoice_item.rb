class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :unit_price, presence: true, numericality: true

  belongs_to :item
  belongs_to :invoice
end

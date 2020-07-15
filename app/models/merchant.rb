class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices

  def self.most_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 'success'")
    .group("merchants.id")
    .order("SUM(invoice_items.unit_price * invoice_items.quantity) DESC")
    .limit(quantity)
  end
end

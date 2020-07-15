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

  def self.most_items_sold(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 'success'")
    .group("merchants.id")
    .order("SUM(invoice_items.quantity) DESC")
    .limit(quantity)
  end

  def revenue
    query = "SELECT SUM(ii.unit_price * ii.quantity) AS revenue FROM invoices
             JOIN invoice_items ii ON ii.invoice_id = invoices.id
             JOIN transactions t ON t.invoice_id = invoices.id
             WHERE t.result = 'success' AND invoices.merchant_id = #{id}"
    ActiveRecord::Base.connection.execute(query)
  end
end

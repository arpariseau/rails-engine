class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  def self.total_revenue(start_date, end_date)
    start = convert_dates(start_date)
    finish = convert_dates(end_date)
    query = "SELECT SUM(ii.unit_price * ii.quantity) AS revenue FROM invoices
             JOIN invoice_items ii ON ii.invoice_id = invoices.id
             JOIN transactions t ON t.invoice_id = invoices.id
             WHERE t.result = 'success' AND invoices.created_at BETWEEN
             '#{start.strftime("%Y-%m-%d")}' AND
             '#{(finish + 1).strftime("%Y-%m-%d")}'"
    ActiveRecord::Base.connection.execute(query)
  end

  def self.convert_dates(date_string)
    date_array = date_string.split('-').map { |date| date.to_i }
    Date.new(date_array[0], date_array[1], date_array[2])
  end
end

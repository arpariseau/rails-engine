class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.search_for(attributes)
    sql_search = attributes.map do |key, value|
      "LOWER(items.#{key}) LIKE '%#{value.downcase}%'"
    end.join(" AND ")
    Item.where(sql_search).first
  end

end

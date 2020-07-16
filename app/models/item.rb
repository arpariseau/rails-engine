class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  def self.search_all(attributes)
    sql_search = attributes.map do |key, value|
      if value[4] == '-' && value[7] == '-'
        "DATE(items.#{key}) = '#{value}'"
      elsif value.to_f != 0.0
        "items.#{key} = #{value}"
      else
        "LOWER(items.#{key}) LIKE '%#{value.downcase}%'"
      end
    end.join(" AND ")
    Item.where(sql_search)
  end

  def self.search_for(attributes)
    search_all(attributes).first
  end

end

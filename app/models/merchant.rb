class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices
end

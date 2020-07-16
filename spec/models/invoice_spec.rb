require 'rails_helper'

describe Invoice, type: :model do
  describe "relationships" do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :transactions}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end

  describe "class methods" do
    it ".total_revenue" do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)
      invoice_3 = create(:invoice)
      invoice_4 = create(:invoice)

      create(:invoice_item, unit_price: 10, quantity: 4, invoice: invoice_1)
      create(:invoice_item, unit_price: 12, quantity: 5, invoice: invoice_2)
      create(:invoice_item, unit_price: 15, quantity: 3, invoice: invoice_3)
      create(:invoice_item, unit_price: 11, quantity: 5, invoice: invoice_4)

      create(:transaction, invoice: invoice_1)
      create(:transaction, invoice: invoice_2)
      create(:transaction, invoice: invoice_3)

      invoice_1.update(created_at: Date.new(2016, 04, 01))
      invoice_2.update(created_at: Date.new(2016, 04, 02))
      invoice_4.update(created_at: Date.new(2016, 04, 04))

      revenue = Invoice.total_revenue("2016-04-01", "2016-04-05")
      expect(revenue.to_a.first["revenue"]).to eq(100)
    end

    it ".convert_dates" do
      invoice = create(:invoice)
      date_string = invoice.created_at.strftime("%Y-%m-%d")
      converted_date = Invoice.convert_dates(date_string)
      expect(converted_date).to eq(invoice.created_at.to_date)
    end
  end
end

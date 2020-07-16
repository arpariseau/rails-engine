require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
  end

  describe "relationships" do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:customers).through(:invoices)}
  end

  describe "class methods" do
    before :each do
      @merchant_a = create(:merchant, name: "Johnny Bravo")
      @merchant_b = create(:merchant, name: "Alpha bravo charlie")
      @merchant_c = create(:merchant, name: "Delta Echo Foxtrot")
    end

    it '.search_all' do
      search_hash = { name: "BRAVO", created_at: Date.today.strftime("%Y-%m-%d") }
      results = Merchant.search_all(search_hash)

      expect(results).to include(@merchant_a)
      expect(results).to include(@merchant_b)
      expect(results).to_not include(@merchant_c)
    end

    it '.search_for' do
      search_hash = { id: @merchant_c.id.to_s, updated_at: Date.today.strftime("%Y-%m-%d") }
      expect(Merchant.search_for(search_hash)).to eq(@merchant_c)
    end

    it '.most_revenue' do
      item_a = create(:item, merchant: @merchant_a)
      invoice_a = create(:invoice, merchant: @merchant_a)
      create(:invoice_item, item: item_a, invoice: invoice_a, unit_price: 10, quantity: 5)
      create(:transaction, invoice: invoice_a)

      item_b = create(:item, merchant: @merchant_b)
      invoice_b = create(:invoice, merchant: @merchant_b)
      create(:invoice_item, item: item_b, invoice: invoice_b, unit_price: 5, quantity: 8)
      transaction_b = create(:transaction, invoice: invoice_b)

      item_c = create(:item, merchant: @merchant_c)
      invoice_c = create(:invoice, merchant: @merchant_c)
      create(:invoice_item, item: item_c, invoice: invoice_c, unit_price: 2, quantity: 15)
      create(:transaction, invoice: invoice_c)

      results = Merchant.most_revenue(2)
      expect(results.first).to eq(@merchant_a)
      expect(results.last).to eq(@merchant_b)
      expect(results).to_not include(@merchant_c)

      transaction_b.update(result: "failed")

      failed_results = Merchant.most_revenue(2)
      expect(failed_results.first).to eq(@merchant_a)
      expect(failed_results).to_not include(@merchant_b)
      expect(failed_results.last).to eq(@merchant_c)
    end

    it '.most_items_sold' do
      item_a = create(:item, merchant: @merchant_a)
      invoice_a = create(:invoice, merchant: @merchant_a)
      create(:invoice_item, item: item_a, invoice: invoice_a, unit_price: 10, quantity: 5)
      create(:transaction, invoice: invoice_a)

      item_b = create(:item, merchant: @merchant_b)
      invoice_b = create(:invoice, merchant: @merchant_b)
      create(:invoice_item, item: item_b, invoice: invoice_b, unit_price: 5, quantity: 8)
      transaction_b = create(:transaction, invoice: invoice_b)

      item_c = create(:item, merchant: @merchant_c)
      invoice_c = create(:invoice, merchant: @merchant_c)
      create(:invoice_item, item: item_c, invoice: invoice_c, unit_price: 2, quantity: 15)
      create(:transaction, invoice: invoice_c)

      results = Merchant.most_items_sold(2)
      expect(results).to_not include(@merchant_a)
      expect(results.last).to eq(@merchant_b)
      expect(results.first).to eq(@merchant_c)

      transaction_b.update(result: "failed")

      failed_results = Merchant.most_items_sold(2)
      expect(failed_results.last).to eq(@merchant_a)
      expect(failed_results).to_not include(@merchant_b)
      expect(failed_results.first).to eq(@merchant_c)

    end
  end

  describe "instance methods" do
    it '#revenue' do
      merchant = create(:merchant)
      invoice_1 = create(:invoice, merchant: merchant)
      invoice_2 = create(:invoice, merchant: merchant)
      create(:invoice_item, unit_price: 4, quantity: 10, invoice: invoice_1)
      create(:invoice_item, unit_price: 5, quantity: 12, invoice: invoice_1)
      create(:invoice_item, unit_price: 3, quantity: 15, invoice: invoice_2)
      create(:transaction, invoice: invoice_1)

      expect(merchant.revenue.to_a.first["revenue"]).to eq(100)
    end
  end
end

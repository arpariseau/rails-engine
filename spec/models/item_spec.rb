require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe "class methods" do
    before :each do
      @merchant = create(:merchant)
      @item_a = create(:item, name: "Sought after", description: "Not this", merchant: @merchant)
      @item_b = create(:item, name: "Other thing", description: "Looking for this", merchant: @merchant)
    end

    it ".search_all" do
      item_c = create(:item, name: "Not at all", description: "what I want", merchant: @merchant)
      search_hash = {name: "er", description: "this", merchant_id: @merchant.id.to_s }
      results = Item.search_all(search_hash)

      expect(results).to include(@item_a)
      expect(results).to include(@item_b)
      expect(results).to_not include(item_c)
    end

    it ".search_for" do
      search_hash = {id: @item_a.id.to_s,
                     unit_price: @item_a.unit_price.to_s,
                     created_at: Date.today.strftime("%Y-%m-%d"),
                     updated_at: Date.today.strftime("%Y-%m-%d") }
      expect(Item.search_for(search_hash)).to eq(@item_a)
    end
  end
end

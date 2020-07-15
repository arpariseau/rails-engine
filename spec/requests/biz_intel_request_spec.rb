require 'rails_helper'

describe 'an api request' do
  before :each do
    @merchant_a = create(:merchant)
    item_a = create(:item, merchant: @merchant_a)
    invoice_a = create(:invoice, merchant: @merchant_a)
    create(:invoice_item, item: item_a, invoice: invoice_a, unit_price: 10, quantity: 5)
    @transaction_a = create(:transaction, invoice: invoice_a)

    @merchant_b = create(:merchant)
    item_b = create(:item, merchant: @merchant_b)
    invoice_b = create(:invoice, merchant: @merchant_b)
    create(:invoice_item, item: item_b, invoice: invoice_b, unit_price: 5, quantity: 8)
    @transaction_b = create(:transaction, invoice: invoice_b)

    @merchant_c = create(:merchant)
    item_c = create(:item, merchant: @merchant_c)
    invoice_c = create(:invoice, merchant: @merchant_c)
    create(:invoice_item, item: item_c, invoice: invoice_c, unit_price: 2, quantity: 15)
    @transaction_c = create(:transaction, invoice: invoice_c)
  end

  it 'can get the merchant(s) with the most revenue' do
    get api_v1_merchants_most_revenue_path, params: {quantity: 1}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(1)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_a.id)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_a.name)

    get api_v1_merchants_most_revenue_path, params: {quantity: 2}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(2)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_a.id)
    expect(resp_merch.last[:id].to_i).to eq(@merchant_b.id)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_a.name)
    expect(resp_merch.last[:attributes][:name]).to eq(@merchant_b.name)

    @transaction_b.update(result: "failed")

    get api_v1_merchants_most_revenue_path, params: {quantity: 2}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(2)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_a.id)
    expect(resp_merch.last[:id].to_i).to eq(@merchant_c.id)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_a.name)
    expect(resp_merch.last[:attributes][:name]).to eq(@merchant_c.name)
  end

  it 'can get the merchant(s) with the most items sold' do
    get api_v1_merchants_most_items_path, params: {quantity: 1}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(1)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_c.id)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_c.name)

    get api_v1_merchants_most_items_path, params: {quantity: 2}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(2)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_c.id)
    expect(resp_merch.last[:id].to_i).to eq(@merchant_b.id)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_c.name)
    expect(resp_merch.last[:attributes][:name]).to eq(@merchant_b.name)

    @transaction_b.update(result: "failed")

    get api_v1_merchants_most_items_path, params: {quantity: 2}
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_merch.count).to eq(2)
    expect(resp_merch.last[:id].to_i).to eq(@merchant_a.id)
    expect(resp_merch.first[:id].to_i).to eq(@merchant_c.id)
    expect(resp_merch.last[:attributes][:name]).to eq(@merchant_a.name)
    expect(resp_merch.first[:attributes][:name]).to eq(@merchant_c.name)
  end

  xit 'can get revenue across a date range' do

  end

  it 'can get revenue for a merchant' do
    get api_v1_merchant_revenue_path(@merchant_a)
    resp = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(resp[:revenue].to_f).to eq(50)
  end
end

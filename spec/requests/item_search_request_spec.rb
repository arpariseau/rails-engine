require 'rails_helper'

describe 'an api request' do
  before :each do
    @merchant = create(:merchant)
    @item_a = create(:item, name: "Sought after", description: "Not this", merchant: @merchant)
    @item_b = create(:item, name: "Other thing", description: "Looking for this", merchant: @merchant)
    @item_c = create(:item, name: "Not at all", description: "what I want", merchant: @merchant)
  end

  it 'can find a single item that matches parameters' do
    get api_v1_items_find_path, params: {name: "soug"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(@item_a.name).to eq(resp_item[:name])

    get api_v1_items_find_path, params: {name: "ER", description: "LoOkInG fOr"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(@item_b.name).to eq(resp_item[:name])
    expect(@item_b.description).to eq(resp_item[:description])

    @item_c.update(created_at: Date.new(2015, 05, 03))
    get api_v1_items_find_path, params: { id: @item_c.id,
                                          unit_price: @item_c.unit_price,
                                          merchant_id: @merchant.id,
                                          created_at: '2015-05-03',
                                          updated_at: Date.today.strftime("%Y-%m-%d") }
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(@item_c.id).to eq(resp_item[:id].to_i)
    expect(@item_c.unit_price).to eq(resp_item[:attributes][:unit_price].to_f)
    expect(@item_c.merchant_id).to eq(resp_item[:attributes][:merchant_id].to_i)
  end

  it 'can find all items that match parameters' do
    get api_v1_items_find_all_path, params: {merchant_id: @merchant.id }
    resp_items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_items.count).to eq(3)
    expect(resp_items.first[:attributes][:merchant_id]).to eq(@merchant.id)
    expect(resp_items.second[:attributes][:merchant_id]).to eq(@merchant.id)
    expect(resp_items.last[:attributes][:merchant_id]).to eq(@merchant.id)

    get api_v1_items_find_all_path, params: {name: "ER", description: "This" }
    resp_items = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resp_items.count).to eq(2)

    names = resp_items.map { |item| item[:attributes][:name] }
    expect(names).to include(@item_a.name)
    expect(names).to include(@item_b.name)

    descriptions = resp_items.map { |item| item[:attributes][:description] }
    expect(descriptions).to include(@item_a.description)
    expect(descriptions).to include(@item_b.description)
  end

end

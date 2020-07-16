require 'rails_helper'

describe 'an api request' do
  before :each do
    @merchant = create(:merchant)
    @item_a = create(:item, name: "Sought after", description: "Not this", unit_price: 50, merchant: @merchant)
    @item_b = create(:item, name: "Other thing", description: "Looking for this")
  end
  it 'can find a single item that matches parameters' do
    get api_v1_items_find_path, params: {name: "soug"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(@item_a.name).to eq(resp_item[:name])

    get api_v1_items_find_path, params: {name: "ER", description: "LoOkInG fOr"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(@item_b.name).to eq(resp_item[:name])
    expect(@item_b.description).to eq(resp_item[:description])

    @item_a.update(created_at: Date.new(2015, 05, 03))
    get api_v1_items_find_path, params: { id: @item_a.id,
                                          unit_price: 50,
                                          merchant_id: @merchant.id,
                                          created_at: '2015-05-03',
                                          updated_at: Date.today.strftime("%Y-%m-%d") }
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(@item_a.id).to eq(resp_item[:id].to_i)
    expect(@item_a.unit_price).to eq(resp_item[:attributes][:unit_price].to_f)
    expect(@item_a.merchant_id).to eq(resp_item[:attributes][:merchant_id].to_i)

  end

  it 'can find all items that match parameters' do

  end

end

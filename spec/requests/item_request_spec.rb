require 'rails_helper'

describe 'an api request' do
  before :each do
    create_list(:item, 3)
  end

  it 'can get a single item' do
    test_item = Item.first
    get api_v1_item_path(test_item)
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(test_item.name).to eq(resp_item[:name])
    expect(test_item.description).to eq(resp_item[:description])
    expect(test_item.unit_price).to eq(resp_item[:unit_price])
    expect(test_item.merchant_id).to eq(resp_item[:merchant_id])
  end

  it 'can get all items' do

  end

  it 'can post a new item' do

  end

  it 'can delete an item' do

  end

  it 'can update an existing item' do

  end
end

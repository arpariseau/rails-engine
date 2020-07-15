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
    get api_v1_items_path
    resp_items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(resp_items.count).to eq(3)
    resp_items.each do |item|
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end

  it 'can post a new item' do
    merchant = create(:merchant)
    new_item = build(:item, merchant: merchant)
    new_params = { name: new_item.name,
                   description: new_item.description,
                   unit_price: new_item.unit_price,
                   merchant_id: merchant.id }

    post api_v1_items_path, params: new_params
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    post_item = Item.last
    expect(post_item.name).to eq(new_item.name)
    expect(post_item.description).to eq(new_item.description)
    expect(post_item.unit_price).to eq(new_item.unit_price)
    expect(post_item.merchant_id).to eq(new_item.merchant_id)

    expect(post_item.name).to eq(resp_item[:name])
    expect(post_item.description).to eq(resp_item[:description])
    expect(post_item.unit_price).to eq(resp_item[:unit_price])
    expect(post_item.merchant_id).to eq(resp_item[:merchant_id])
  end

  it 'can delete an item' do
    del_item = Item.last
    delete api_v1_item_path(del_item)
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(Item.all).to_not include(del_item)
    expect(del_item.name).to eq(resp_item[:name])
    expect(del_item.description).to eq(resp_item[:description])
    expect(del_item.unit_price).to eq(resp_item[:unit_price])
    expect(del_item.merchant_id).to eq(resp_item[:merchant_id])
  end

  it 'can update an existing item' do
    merchant = create(:merchant)
    update_item = build(:item)
    edit_item = Item.first
    edit_params = { name: update_item.name,
                    description: update_item.description,
                    unit_price: update_item.unit_price,
                    merchant_id: merchant.id }

    patch api_v1_item_path(edit_item), params: edit_params
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    edited_item = Item.first
    expect(edited_item.name).to eq(update_item.name)
    expect(edited_item.description).to eq(update_item.description)
    expect(edited_item.unit_price).to eq(update_item.unit_price)
    expect(edited_item.merchant_id).to eq(merchant.id)

    expect(edited_item.name).to eq(resp_item[:name])
    expect(edited_item.description).to eq(resp_item[:description])
    expect(edited_item.unit_price).to eq(resp_item[:unit_price])
    expect(edited_item.merchant_id).to eq(resp_item[:merchant_id])
  end

  it 'can show a merchant for an item' do
    test_item = Item.first

    get api_v1_item_path(test_item)
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(test_item.merchant_id).to eq(resp_item[:relationships][:merchant][:data][:id].to_i)

    get api_v1_item_merchant_path(test_item)
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(test_item.merchant_id).to eq(resp_item[:id].to_i)
  end
end

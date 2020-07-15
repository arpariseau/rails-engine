require 'rails_helper'

describe 'an api request' do
  before :each do
    create_list(:merchant, 3)
  end

  it 'can get a single merchant' do
    test_merch = Merchant.first
    get api_v1_merchant_path(test_merch)
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(test_merch.name).to eq(resp_merch[:name])
  end

  it 'can get all merchants' do
    get api_v1_merchants_path
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(3)
    merchants.each do |merch|
      expect(merch[:type]).to eq("merchant")
      expect(merch[:attributes]).to have_key(:name)
    end
  end

  it 'can post a new merchant' do
    new_merch = build(:merchant)
    new_params = { name: new_merch.name }

    post api_v1_merchants_path, params: new_params
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    post_merch = Merchant.last
    expect(new_merch.name).to eq(post_merch.name)
    expect(new_merch.name).to eq(resp_merch[:name])
  end

  it 'can delete a merchant' do
    del_merch = Merchant.last
    delete api_v1_merchant_path(del_merch)
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(Merchant.all).to_not include(del_merch)
    expect(del_merch.name).to eq(resp_merch[:name])
  end

  it 'can update an existing merchant' do
    update_merch = build(:merchant)
    edit_merch = Merchant.first
    edit_params = { name: update_merch.name }

    patch api_v1_merchant_path(edit_merch), params: edit_params
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    edited_merch = Merchant.first
    expect(edited_merch.name).to eq(update_merch.name)
    expect(edited_merch.name).to eq(resp_merch[:name])
  end

  it 'can show items for a merchant' do
    test_merchant = Merchant.first
    item_a = create(:item, merchant: test_merchant)
    item_b = create(:item, merchant: test_merchant)
    item_c = create(:item, merchant: Merchant.last)

    get api_v1_merchant_path(test_merchant)
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    test_merchant_items = resp_merch[:relationships][:items][:data]
    test_item_ids = test_merchant_items.map {|item| item[:id].to_i}
    expect(test_item_ids.count).to eq(2)
    expect(test_item_ids).to include(item_a.id)
    expect(test_item_ids).to include(item_b.id)
    expect(test_item_ids).to_not include(item_c.id)

    get api_v1_merchant_items_path(test_merchant)
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    test_item_ids = test_merchant_items.map {|item| item[:id].to_i}
    expect(test_item_ids.count).to eq(2)
    expect(test_item_ids).to include(item_a.id)
    expect(test_item_ids).to include(item_b.id)
    expect(test_item_ids).to_not include(item_c.id)

  end
end

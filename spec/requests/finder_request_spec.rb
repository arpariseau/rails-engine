require 'rails_helper'

describe 'an api request' do
  it 'can find a single item that matches parameters' do
    item_a = create(:item, name: "Sought after", description: "Not this")
    item_b = create(:item, name: "Other thing", description: "Looking for this")

    get api_v1_items_find_path, params: {name: "soug"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(item_a.name).to eq(resp_item[:name])

    get api_v1_items_find_path, params: {name: "er", description: "Looking for"}
    resp_item = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(item_b.name).to eq(resp_item[:name])
    expect(item_b.description).to eq(resp_item[:description])
  end

  xit 'can find all items that match parameters' do

  end

  xit 'can find a single merchant that matches parameters' do

  end

  xit 'can find all merchants that match paramters' do

  end
end

require 'rails_helper'

describe 'an api request' do
  before :each do
    @merchant_a = create(:merchant, name: "John Q. Public's")
    @merchant_b = create(:merchant, name: "John Doe's")
    @merchant_c = create(:merchant, name: "Jacob Jingleheimerschmidt's")
  end

  it 'can find a single merchant that matches parameters' do
    get api_v1_merchants_find_path, params: { name: 'pub' }
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(@merchant_a.name).to eq(resp_merch[:name])

    @merchant_b.update(created_at: Date.new(2018, 03, 06))
    get api_v1_merchants_find_path, params: { id: @merchant_b.id,
                                              name: 'JO',
                                              created_at: '2018-03-06',
                                              updated_at: Date.today.strftime("%Y-%m-%d") }
    resp_merch = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(@merchant_b.id).to eq(resp_merch[:id].to_i)
  end

  xit 'can find all merchants that match paramters' do

  end
end

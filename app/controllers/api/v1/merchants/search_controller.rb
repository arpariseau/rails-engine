class Api::V1::Merchants::SearchController < ApplicationController
  def show
    attributes = search_params.to_h
    render json:MerchantSerializer.new(Merchant.search_for(attributes))
  end

  def index
    attributes = search_params.to_h
    render json:MerchantSerializer.new(Merchant.search_all(attributes))
  end

  private

  def search_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end

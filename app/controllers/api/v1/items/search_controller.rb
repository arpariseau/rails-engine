class Api::V1::Items::SearchController < ApplicationController
  def show
    attributes = search_params.to_h
    render json:ItemSerializer.new(Item.search_for(attributes))
  end

  def index
    attributes = search_params.to_h
    render json:ItemSerializer.new(Item.search_all(attributes))
  end

  private

  def search_params
    params.permit(:id, :name, :description, :unit_price,
                  :merchant_id, :created_at, :updated_at)
  end
end

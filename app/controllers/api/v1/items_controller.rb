class Api::V1::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    render json: merchant.items.create(item_params)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end

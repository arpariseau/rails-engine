class Api::V1::ItemsController < ApplicationController
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    render json: ItemSerializer.new(merchant.items.create(item_params))
  end

  def destroy
    item = Item.find(params[:id])
    Item.delete(item)
    render json: ItemSerializer.new(item)
  end

  def update
    item = Item.find(params[:id])
    item.update(edit_params)
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def edit_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end

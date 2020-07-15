class Api::V1::MerchantsController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def destroy
    merchant = Merchant.find(params[:id])
    Merchant.delete(merchant)
    render json: MerchantSerializer.new(merchant)
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def merchant_params
    params.permit(:name)
  end

end

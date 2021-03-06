class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = if params[:quantity].nil?
                  Merchant.most_revenue(Merchant.all.count)
                else
                  Merchant.most_revenue(params[:quantity])
                end
    render json:MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    render json:RevenueSerializer.new(merchant.revenue).revenue_return
  end
end

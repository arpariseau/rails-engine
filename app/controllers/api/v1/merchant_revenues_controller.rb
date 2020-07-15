class Api::V1::MerchantRevenuesController < ApplicationController
  def index
  merchants = if params[:quantity].nil?
                Merchant.most_revenue(1)
              else
                Merchant.most_revenue(params[:quantity])
              end
  render json:MerchantSerializer.new(merchants)
  end
end

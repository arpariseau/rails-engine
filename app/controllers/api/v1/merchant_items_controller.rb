class Api::V1::MerchantItemsController < ApplicationController
  def index
  merchants = if params[:quantity].nil?
                Merchant.most_items_sold(1)
              else
                Merchant.most_items_sold(params[:quantity])
              end
  render json:MerchantSerializer.new(merchants)
  end
end

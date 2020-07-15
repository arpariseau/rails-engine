class Api::V1::RevenueController < ApplicationController
  def show
    total_revenue = Invoice.total_revenue(params[:start], params[:end])
    render json:RevenueSerializer.new(total_revenue).revenue_return
  end
end

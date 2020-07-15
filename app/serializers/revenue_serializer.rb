class RevenueSerializer
  def initialize(revenue)
    @revenue = revenue.to_a
  end

  def revenue_return
    { data:
       {
        id: nil,
        attributes: @revenue.first.symbolize_keys
      }
    }
  end
end

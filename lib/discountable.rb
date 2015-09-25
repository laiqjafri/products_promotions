module Discountable
  def discounted_price
    self.gross_total - self.discount
  end

  def discount
    self.promotions.inject(0.0) do |total_discount, promotion|
      total_discount += promotion.discount_on(self)
    end
  end
end

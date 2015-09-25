class Promotion
  attr_reader :x, :y
  def initialize x, y
    @x = x.to_f
    @y = y.to_f
  end
end

class PromotionXPercentOffOnY < Promotion
  def discount_on item
    return 0.0 if item.gross_total < y
    item.gross_total * (x / 100)
  end
end

class PromotionXPriceOnYItems < Promotion
  def discount_on item
    return 0.0 if item.quantity < y
    item.gross_total - (x * item.quantity)
  end
end

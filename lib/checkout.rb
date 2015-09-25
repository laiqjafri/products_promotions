require File.join(__dir__, "item")
require File.join(__dir__, "promotion")

class Checkout
  include Discountable
  attr_accessor :basket, :promotions
  attr_reader :quantity

  def initialize promotions = []
    @basket      = {}
    @quantity   = 1
    @promotions = promotions
  end

  def scan item
    if self.basket[item.code].nil?
      item.quantity = 1
      self.basket[item.code] = item
    else
      self.basket[item.code].quantity += 1
    end
  end

  def gross_total
    self.basket.inject(0.0) { |sum, (code, item)| sum += item.discounted_price }
  end

  def total
    self.discounted_price.round(2)
  end

  def empty!
    self.basket = {}
  end

  def basket_count
    self.basket.inject(0) { |sum, (code, item)| sum += item.quantity }
  end
end

require File.join(__dir__, "discountable")

class Item
  include Discountable
  attr_accessor :code, :name, :price, :quantity, :promotions

  def initialize code, name, price, promotions = []
    @code  = code
    @name  = name
    @price = price.to_f

    @promotions = promotions
  end

  def gross_total
    self.price * self.quantity.to_i
  end
end

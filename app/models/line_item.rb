class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  
  def unit_price
    product.price
  end
  
  def total_price
    product.price * quantity
  end
end

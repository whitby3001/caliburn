class LineItem < ActiveRecord::Base
  belongs_to :basket
  belongs_to :product
  
  validate :product_is_in_stock
  
  def unit_price
    product.price
  end
  
  def total_price
    product.price * quantity
  end
  
  def total_postage
    product.postage_cost * quantity rescue 0
  end
  
  private
  
  def product_is_in_stock
    errors[:base] << "Product is not in stock" if product.quantity <= 0
  end
end

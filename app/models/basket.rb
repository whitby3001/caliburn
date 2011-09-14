class Basket < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product) 
    product = Product.find(product.id)
    current_item = line_items.where(:product_id => product.id).first 
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product.id)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum { |item| item.total_price + item.total_postage }
  end
  
  def total_postage
    line_items.to_a.sum { |item| item.total_postage }
  end
end

class Basket < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :payment_notifications
  
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
  
  def paypal_url(return_url, notify_url)
    values = {
      :business => PAYPAL_CONFIG['seller'],
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :currency_code => "GBP",
      :handling_cart => total_postage,
      :notify_url => notify_url,
      :invoice => id
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.unit_price,
        "item_name_#{index+1}" => item.product.name,
        "item_number_#{index+1}" => item.product.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    PAYPAL_CONFIG['url'] + values.to_query
  end
end

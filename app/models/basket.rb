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
    actual = line_items.to_a.sum { |item| item.total_postage }
    if line_items.any? {|l| l.product.postage_cost > 12 }
      return actual
    else
      actual > 12 ? 12 : actual
    end
  end
  
  def paypal_encrypted(return_url, notify_url)
    values = {
      :business => PAYPAL_EMAIL,
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :currency_code => "GBP",
      :handling_cart => total_postage,
      :notify_url => notify_url,
      :invoice => id,
      :cert_id => PAYPAL_CERT_ID
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.unit_price,
        "item_name_#{index+1}" => item.product.name,
        "item_number_#{index+1}" => item.product.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    encrypt_for_paypal(values)
  end

  def encrypt_for_paypal(values)
    signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM), OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), values.map { |k, v| "#{k}=#{v}" }.join("\n"), [], OpenSSL::PKCS7::BINARY)
    OpenSSL::PKCS7::encrypt([OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], signed.to_der, OpenSSL::Cipher::Cipher::new("DES3"), OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
  end
end

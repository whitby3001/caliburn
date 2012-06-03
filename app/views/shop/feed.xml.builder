xml.instruct! :xml, :version => "1.0" 

xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version => "2.0") do
  xml.channel do
    xml.title "Caliburn Entertainment"
    xml.link "http://www.caliburnentertainment.co.uk"
    xml.description "Google product feed"
    Product.all.each do |product|
      if product.has_all_google_fields?
        xml.item do
          xml.tag!("g:id") do
            xml.text! product.id.to_s
          end
          xml.title do
            xml.text! product.name.titleize
          end
          xml.description do
            xml.text! product.description
          end
          xml.tag!("g:google_product_category") do
            xml.text! product.category.google_category
          end
          xml.tag!("g:product_type") do
            xml.text! product.category_breadcrumb("&gt;")
          end
          xml.link do
            xml.text! "http://www.caliburnentertainment.co.uk" + product_path(product)
          end
          xml.tag!("g:image_link") do
            xml.text! product.image.url(:medium)
          end
          product.additional_images.each do |add_image|
            xml.tag!("g:additional_image_link") do
              xml.text! add_image.image.url(:medium)
            end
          end
          xml.tag!("g:condition") do
            xml.text! product.condition
          end
          xml.tag!("g:availability") do
            xml.text! product.quantity > 0 ? 'in stock' : 'out of stock'
          end
          xml.tag!("g:price") do
            xml.text! "#{number_to_currency(product.price.to_s, :unit => '')} GBP"
          end
          xml.tag!("g:sale_price") do
            xml.text! "#{number_to_currency(product.price.to_s, :unit => '')} GBP"
          end
          xml.tag!("g:brand") do
            xml.text! product.brand
          end
          xml.tag!("g:gtin") do
            xml.text! product.barcode
          end
          xml.tag!("g:mpn") do
            xml.text! product.mpn
          end
          xml.tag!("g:shipping") do 
            xml.tag!("g:country") do
              xml.text! "GB"
            end
            xml.tag!("g:service") do
              xml.text! "Royal Mail"
            end
            xml.tag!("g:price") do
              xml.text! number_to_currency(product.postage_cost, :unit => 'GBP', :format => '%n %u')
            end
          end
        end
      end
    end
  end
end
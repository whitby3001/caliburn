class Product < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :category
  
  has_attached_file :image, 
                    :styles => { :medium => ["300x300>", :png], :small => ["200x200", :png], :thumb => ["100x100", :png] },
                    :convert_options => {:thumbnail => "-background transparent -gravity center -extent 100x100", :small => "-background transparent -gravity center -extent 200x200"},
                    :storage => (Rails.env.production? ? :s3 : :filesystem), 
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => (Rails.env.production? ? "/:class/:attachment/:id/:style/:filename" : "/system/:attachment/:id/:style/:filename")
  
  validates_presence_of :name, :category, :description, :price, :quantity, :postage_cost
  validates_numericality_of :price, :postage_cost
  validates :barcode, :length => {:in => 8..13}, :allow_blank => true
  
  scope :in_stock, where("quantity > 0")
  scope :featured, where(:featured => true)
  
  def category_breadcrumb(joiner = ">")
    category.nil? ? nil : category.category_breadcrumb(joiner)
  end
  
  def has_all_google_fields?
    !name.blank? and !description.blank? and (!google_category.blank? or !category.google_category.blank?) and !category.nil? and !image.nil? and !condition.blank? and !price.blank? and !brand.blank? and !barcode.blank? and !postage_cost.blank?
  end
  
  def self.generate_google_product_xml
    include Rails.application.routes.url_helpers
    
    xml_str = ""
    xml = Builder::XmlMarkup.new(:target => xml_str, :indent => 2)
    xml.instruct! :xml, :version=>"1.0"
    
    xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version => "2.0") {
      xml.channel {
        xml.title "Caliburn Entertainment"
        xml.link "http://www.caliburnentertainment.co.uk"
        xml.description "Google product feed"
        Product.all.each do |product|
          if product.has_all_google_fields?
            xml.item {
              xml.tag!("g:id") { product.id.to_s }
              xml.title { product.name.titleize }
              xml.description { product.description }
              xml.tag!("g:google_category") { product.google_product_category.blank? ? product.category.google_product_category : product.google_product_category }
              xml.tag!("g:product_type") { product.category_breadcrumb("&gt;") }
              xml.link { "http://www.caliburn_entertainment.co.uk" + product_path(product) }
              xml.tag!("g:image_link") { product.image.url }
              xml.tag!("g:availability") { product.quantity > 0 ? 'in stock' : 'out of stock' }
              xml.tag!("g:price") { "#{product.price.to_s} GBP" }
              xml.tag!("g:sale_price") { "#{product.price.to_s} GBP" }
              xml.tag!("g:brand") { product.brand }
              xml.tag!("g:gtin") { product.barcode }
              xml.tag!("g:mpn") { product.mpn }
              xml.tag!("g:shipping") { 
                xml.tag!("g:country") { "GB" }
                xml.tag!("g:service") { "Royal Mail" }
                xml.tag!("g:price") { product.postage_cost.to_s }
              }
            }
          end
        end
      }
    }
    
    xml
  end
end

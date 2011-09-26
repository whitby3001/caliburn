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
    !name.blank? and !description.blank? and !category.google_category.blank? and !category.nil? and !image.nil? and !condition.blank? and !price.blank? and !brand.blank? and !barcode.blank? and !postage_cost.blank?
  end
end

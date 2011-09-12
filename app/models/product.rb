class Product < ActiveRecord::Base
  default_scope :order => 'name'
  
  has_many :line_items, :dependent => :destroy
  belongs_to :category
  
  has_attached_file :image, 
                    :styles => { :medium => ["300x300>", :png], :small => ["200x200", :png], :thumb => ["100x100", :png] },
                    :convert_options => {:thumbnail => "-background transparent -gravity center -extent 100x100", :small => "-background transparent -gravity center -extent 200x200"},
                    :storage => (Rails.env.production? ? :s3 : :filesystem), 
                    :s3_credentials => "#{Rails.root}/config/s3.yml"
  
  validates_presence_of :name, :category, :description, :price, :quantity
  
  def category_breadcrumb
    category.nil? ? nil : category.category_breadcrumb
  end
end

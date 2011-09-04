class Product < ActiveRecord::Base
  default_scope :order => 'name'
  
  has_many :line_items, :dependent => :destroy
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml"
end

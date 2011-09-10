class Category < ActiveRecord::Base
  acts_as_nested_set
  
  #default_scope :order => "lft"
  
  has_many :products
  
  validates_presence_of :name
end

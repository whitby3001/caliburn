class Category < ActiveRecord::Base
  acts_as_nested_set
  
  has_many :products
  
  validates_presence_of :name
  
  def category_breadcrumb
    self_and_ancestors.collect{ |c| c.name.titleize }.join(" > ")
  end
end

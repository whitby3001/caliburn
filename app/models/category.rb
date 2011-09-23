class Category < ActiveRecord::Base
  acts_as_nested_set
  
  has_many :products
  
  validates_presence_of :name, :dasherized_name
  validates_uniqueness_of :name
  
  before_validation :dasherize_name
  
  def category_breadcrumb(joiner = ">")
    self_and_ancestors.collect{ |c| c.name.titleize }.join(" #{joiner} ")
  end
  
  def ancestors_for_route
    return nil if ancestors.empty?
    self.ancestors.collect {|c| c.dasherized_name }.join("/")
  end
  
  private
  
  def dasherize_name
    self.dasherized_name = name.nil? ? nil : name.downcase.gsub(/[^a-z0-9]+/i, '-')
  end
end

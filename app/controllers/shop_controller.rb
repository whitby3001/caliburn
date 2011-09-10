class ShopController < ApplicationController
  def index
    @category = Category.find(params[:category])
    unless @category.nil?
      @root_category = @category.root
      category_and_descendants = @category.self_and_descendants
      @products = Product.where(:category_id => category_and_descendants.collect{|c| c.id})
    else
      @products = Product.all
    end
  end
end

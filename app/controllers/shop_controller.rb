class ShopController < ApplicationController
  def index
    @category = Category.where(:dasherized_name => params[:category]).first
    unless @category.nil?
      @title = @category.category_breadcrumb("")
      @meta_description = "Product listings for #{@title}"
      @root_category = @category.root
      category_and_descendants = @category.self_and_descendants
      @products = Product.in_stock.where(:category_id => category_and_descendants.collect{|c| c.id}).order(:name).page(params[:page]).per(24)
    else
      @title = "All Products"
      @meta_description = "All product listings."
      @products = Product.in_stock.order(:name).page(params[:page]).per(24)
    end
  end
end

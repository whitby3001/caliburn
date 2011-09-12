class ShopController < ApplicationController
  def index
    @category = Category.find(params[:category])
    unless @category.nil?
      @root_category = @category.root
      category_and_descendants = @category.self_and_descendants
      @products = Product.where(:category_id => category_and_descendants.collect{|c| c.id}).order(:name).page(params[:page]).per(24)
    else
      @products = Product.order(:name).page(params[:page]).per(24)
    end
  end
end

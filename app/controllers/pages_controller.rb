class PagesController < ApplicationController
  def home
    @title = "Home"
    @featured_products = Product.in_stock.featured.limit(3)
    @new_products = Product.order("created_at DESC").limit(3)
    render :layout => "home"
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About Us"
  end

end

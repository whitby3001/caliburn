class PagesController < ApplicationController
  def home
    @full_title = "Caliburn Entertainment - Buy Miniatures, Toys, Transformers, Star Wars, Warhammer"
    @featured_products = Product.in_stock.featured.limit(3)
    @new_products = Product.order("created_at DESC").limit(3)
    @meta_description = "Caliburn Entertainment sells a wide variety of toys, action figures, miniatures and books. We specialise in Transformers, Star Wars, Warhammer 40K and many other science fiction and fantasy related items."
    render :layout => "home"
  end

  def contact
    @title = "Contact"
    @meta_description = "Contact information for Caliburn Entertainment."
  end
  
  def about
    @title = "About Us"
    @meta_description = "What we do, who we are and the history of Caliburn Entertainment."
  end
  
  def terms
    @title = "Terms & Conditions"
    @meta_description = "Information on our terms and conditions including postage costs and returns."
  end
  
  def exception_notification_test
    raise "This is a test"
  end

end

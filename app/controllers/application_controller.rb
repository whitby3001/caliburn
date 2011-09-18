class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end
  
  private
  
  def current_basket
    if session[:basket_id]
      basket = Basket.find(session[:basket_id])
      session[:basket_id] = nil if basket.purchased_at
    end
    if session[:basket_id].nil?
      basket = Basket.create!
      session[:basket_id] = basket.id
    end
    basket
  end
  
end

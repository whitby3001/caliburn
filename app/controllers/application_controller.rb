class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end
  
  private
  
  def current_basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound 
    basket = Basket.create 
    session[:basket_id] = basket.id
    basket
  end
end

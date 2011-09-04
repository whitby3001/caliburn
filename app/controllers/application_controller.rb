class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound 
    basket = Basket.create 
    session[:basket_id] = basket.id
    basket
  end
end

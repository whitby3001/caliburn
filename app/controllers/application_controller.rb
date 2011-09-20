class ApplicationController < ActionController::Base
  APP_DOMAIN = 'www.caliburnentertainment.co.uk'
  
  before_filter :ensure_domain
  
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end
  
  private
  
  def current_basket
    if session[:basket_id]
      basket = Basket.where({:id => session[:basket_id]}).first
      session[:basket_id] = nil if basket.nil? or basket.purchased_at
    end
    if session[:basket_id].nil?
      basket = Basket.create!
      session[:basket_id] = basket.id
    end
    basket
  end
  
  def ensure_domain
    if Rails.env.production? and request.env['HTTP_HOST'] != APP_DOMAIN
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
end

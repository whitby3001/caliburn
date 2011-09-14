class BasketController < ApplicationController
  # GET /cart
  def show
    @title = "Your Shopping Basket"
    @basket = current_basket
  end

  # DELETE /cart
  def destroy
    @basket = current_basket 
    @basket.destroy 
    session[:basket_id] = nil
    redirect_to(shop_url, :notice => 'Your shopping basket is currently empty')
  end
end

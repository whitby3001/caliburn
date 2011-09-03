class CartsController < ApplicationController
  # GET /cart
  def show
    @cart = current_cart
  end

  # DELETE /cart
  def destroy
    @cart = current_cart 
    @cart.destroy 
    session[:cart_id] = nil
    redirect_to(products_url, :notice => 'Your cart is currently empty')
  end
end

class LineItemsController < ApplicationController
  # POST /line_items
  def create 
    @basket = current_basket 
    product = Product.find(params[:product_id]) 
    @line_item = @basket.add_product(product)
    if @line_item.save
      redirect_to(basket_path)
    else
      redirect_to(basket_path, :alert => "Unable to add product to shopping basket.")
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    basket = current_basket
    line_item = basket.line_items.find_by_id(params[:id])
    
    unless line_item.nil?
      line_item.destroy 
      redirect_to(basket_path, :notice => "Product removed from your shopping basket.")
    else
      redirect_to(basket_path, :alert => "Product not found in your shopping basket.")
    end
  end
end

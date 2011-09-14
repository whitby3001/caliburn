class LineItemsController < ApplicationController
  # POST /line_items
  def create 
    @basket = current_basket 
    product = Product.find(params[:product_id]) 
    @line_item = @basket.add_product(product)
    if @line_item.save
      redirect_to(basket_path)
    else
      redirect_to(basket_path, :alert => "Unable to add product to shopping basket")
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to line_items_url }
      format.json { head :ok }
    end
  end
end

class ProductsController < ApplicationController
  before_filter :authorize_access, :except => :show
  
  # GET /products
  def index
    @products = Product.order(:name)
  end

  # GET /products/1
  def show
    @product = Product.find(params[:id])
    @title = @product.name
    @meta_description = "Product information for #{@product.name}."
    @all_images = [@product] + @product.additional_images
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    5.times {@product.additional_images.build}
  end

  # POST /products
  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to @product, :notice => 'Product was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /products/1
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to @product, :notice => 'Product was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /products/1
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_url
  end
  
  private
  
  def authorize_access
    authorize! :create, Product
    
  end
end

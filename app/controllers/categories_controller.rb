class CategoriesController < ApplicationController
  load_and_authorize_resource
  
  # GET /categories
  def index
    @categories = Category.order(:lft)
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    if @category.save
      redirect_to @category, :notice => 'Category was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /categories/1
  def update
    if @category.update_attributes(params[:category])
      redirect_to @category, :notice => 'Category was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy

    redirect_to categories_url
  end
end

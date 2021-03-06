class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  layout 'admin'

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    set_category
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      flash_message :success, 'Category was successfully created.'
      redirect_to admin_categories_url
    else
      render action: "new"
    end
  end

  def update
    set_category
    if @category.update(params[:category])
      flash_message :success, 'Category was successfully updated.'
      redirect_to admin_categories_url
    else
      render action: "edit"
    end
  end

  def destroy
    set_category
    @result = Store.last_record(@category, Category.all.count)

    flash_message @result[0], @result[1]
    redirect_to admin_categories_url
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

end

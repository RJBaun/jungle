class Admin::CategoriesController < ApplicationController

  before_action :authenticate

  def index
    @categories = Category.order(id: :desc).all
    
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(product_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def authenticate
    authenticate_or_request_with_http_basic("Admin") do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

end
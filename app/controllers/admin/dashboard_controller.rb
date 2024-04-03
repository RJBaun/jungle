class Admin::DashboardController < ApplicationController

  before_action :authenticate

  def show
    @products_count = Product.count
    @categories_count = Category.count
  end

  def authenticate
    authenticate_or_request_with_http_basic("Admin") do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end

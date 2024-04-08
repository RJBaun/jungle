require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe "Validations" do 
    it "should allow a valid product to be saved" do
      @category = Category.new(name: "test category")
      @product = Product.new(name: "test name", price: 10000, quantity: 20, category: @category)
      @product.save
      expect(@product.errors.full_messages).to be_empty
    end

    it "should not save a product without a name" do
      @category = Category.new(name: "test category")
      @product = Product.new(name: nil, price: 10000, quantity: 20, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save a product without price" do
      @category = Category.new(name: "test category")
      @product = Product.new(name: "test name", price: nil, quantity: 20, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    

    it "should not save a product without a quantity" do
      @category = Category.new(name: "test category")
      @product = Product.new(name: "test name", price: 10000, quantity: nil, category: @category)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save a product without a category" do
      @category = Category.new(name: "test category")
      @product = Product.new(name: "test name", price: 10000, quantity: 20, category: nil)
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages).to include("Category must exist")
    end


  end
end




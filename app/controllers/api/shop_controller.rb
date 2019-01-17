module Api
  class ShopController < ApplicationController
    def show
      # param for returning only products that are in stock
      in_stock = params['in_stock']
      # params for returning only a single product using name or id
      product_name = params['name']
      product_id = params['item_id']
      # Capitalize productName to match names in table and attempt to find product
      if product_name.present?
        product_name.capitalize
        @products = Product.find_by(name: product_name)
        if @products.nil?
          @products = { 'Error': 'Product with inputted name not found' }
        end
      # Attempt to find product using item_id
      elsif product_id.present?
        @products = Product.find_by(item_id: product_id)
        if @products.nil?
          @products = { 'Error': 'Product with inputted item_id not found' }
        end
      elsif in_stock
        @products = Product.where('quantity > 0')
      else
        @products = Product.all
      end
      render json: @products
    end
  end
end

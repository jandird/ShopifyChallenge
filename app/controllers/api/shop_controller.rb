module Api
  class ShopController < ApplicationController

    # Method to GET products
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

    # Method to create a new cart
    def create_cart
      Cart.destroy_all
      render json: {'Success': 'New cart created!'}
    end

    # Method to add to cart
    def add_to_cart
      # Params to find product and how much to place in cart
      product_name = params['name']
      product_id = params['item_id']
      product_quantity = params['quantity'].to_s

      # Making sure necessary params are not empty
      if (product_name.empty? && product_id.empty?) || product_quantity.empty?
        @return = { 'Error': 'Quantity must be specified'} if product_quantity.empty?
        @return = { 'Error': 'One of name or item_id must be specified' } if product_id.empty? && product_name.empty?
        @return = { 'Error': 'Quantity and one of name or item_id must be specified' } if product_id.empty? && product_name.empty? && product_quantity.empty?
      else
        # Finding product
        if product_name.present?
          product_name.capitalize
          @return = Product.find_by(name: product_name)
        else
          @return = Product.find_by(item_id: product_id)
        end

        if @return.nil? # Making sure product was found
          @return = { 'Error': 'Product not found' }
        else
          stock = @return.quantity

          if stock == 0
            @return = { 'Error': 'Product is sold out' }
          elsif stock < product_quantity.to_i
            @return = { 'Error': 'Not enough stock left to meet quantity' }
          else
            if Cart.find_by(item_id: @return.item_id).present?
              @return = { 'Error': 'Product already exists in cart'}
            else
              @return = { 'Success': product_quantity + ' x ' + @return.name + ' added to cart!' }
            end
          end
        end
      end
      render json: @return
    end
  end
end

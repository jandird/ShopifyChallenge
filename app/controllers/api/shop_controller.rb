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
              Cart.create(name: @return.name, description: @return.description, item_id: @return.item_id, price: @return.price, quantity: product_quantity)
              @return = { 'Success': product_quantity + ' x ' + @return.name + ' added to cart!' }
            end
          end
        end
      end
      render json: @return
    end

    # Method to view cart
    def view_cart
      render json: products_in_cart(false)
    end

    # Method to complete cart
    def complete_cart
      render json: { status: 'Success', message: 'Checkout Complete! Thank you for shopping with us!', data: products_in_cart(true) }
      Cart.destroy_all
    end

    # Common method to add cart items to array and remove items from quantity count (complete is to lower product inventory)
    def products_in_cart (complete)
      cart = []
      @total = 0
      Cart.all.each do |item|
        product_total = item.quantity * item.price
        @total += product_total
        cart.append('Name': item.name,
                    'Description': item.description,
                    'Item ID': item.item_id,
                    'Price': item.price,
                    'Quantity': item.quantity,
                    'Subtotal': "$#{product_total.round(2)}")
        if complete
          product = Product.find_by(name: item.name)
          product.update_columns(quantity: product.quantity - item.quantity)
        end
      end
      cart.append('Total': "$#{@total.round(2)}")
      return cart
    end
  end
end

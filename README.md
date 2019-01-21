# ShopifyChallenge
Solution to Shopify's Summer 2019 Developer Intern Challenge Question

# Table of Contents



[Intro](https://github.com/jandird/ShopifyChallenge#intro)

[API Instructions](https://github.com/jandird/ShopifyChallenge#API-Instructions)

[Design Decisions](https://github.com/jandird/ShopifyChallenge#Design-Decisions)

# Intro
Hi, Im Dalip! Thank you for taking a look at my Shopify Coding Challenge.

- This API is meant to be a barebones online marketplace. It allows you to view a list of the items in a store. It also allows you to create, add to, view, and complete a cart. All the instructions on how to use the API can be found in this README at [API Instructions](https://github.com/jandird/ShopifyChallenge#API-Instrunctions).

- The shop allows you to buy superhero names and superpowers.

- The application is deployed on a Google Cloud Platform. This means that you do need install it locally to use it! All my code can however been seen through this git repository if you would like to take a look! Majority of the work can be found in the [shop_controller.rb](https://github.com/jandird/ShopifyChallenge/blob/master/app/controllers/api/shop_controller.rb).

- I outline some of the decisions I made in the [Design Decisions](https://github.com/jandird/ShopifyChallenge#Design-Decisions) section if you would like to take a deeper look into my thought process.


# API Instructions

You can use your favourite tool for calling REST API's to use this web api. All GET requests will provide a JSON list.

**View General Products:**

1. To get a list of ALL products you can use the following GET request `https://shopifychallenge.appspot.com/api/show`

2. To get a list of only products that are not out of stock you can use the following get request `https://shopifychallenge.appspot.com/api/show?in_stock=true`

3. To view only a single product you use the following GET requests `https://shopifychallenge.appspot.com/api/show?name=[ENTER NAME HERE]` OR `https://shopifychallenge.appspot.com/api/show?item_id=[ENTER ITEM_ID HERE]`

**Cart Requests:**

1. To create a new cart you can use the following GET request `https://shopifychallenge.appspot.com/api/create_cart`

2. To add a product to your cart you can use the following GET request: `https://shopifychallenge.appspot.com/api/add_to_cart?name=[ENTER NAME HERE]&quantity=[ENTER QUANTITY HERE]` OR `https://shopifychallenge.appspot.com/api/add_to_cart?item_id=[ENTER ITEM_ID HERE]&quantity=[ENTER QUANTITY HERE]`
     
3. To view the products in you cart you can use the following GET request: `https://shopifychallenge.appspot.com/api/view_cart`. This request will also show the subtotals for each product, and the total cost.

4. To complete the cart you can use the following GET request: `https://shopifychallenge.appspot.com/api/complete_cart`. Completing the cart will lower inventory and automatically create a new cart.


# Design Decisions

- Error Handling has been added for all possible errors when making the above GET requests. 

- This API was developed using Ruby on Rails. I used it because it's used at Shopify and it was a great oppurtunity to learn it! 

- There was no front end required so no views were created, as only controllers and models were need for the API.

- I used MySQL2 as the database for this API. This is because it allowed to create a CloudSQL instance on the Google Cloud Platform, and it is overall much more functional, robust, and widely used than SQLite3.

- I used a seed.rb file to load the products as this API is just meant for test purposes. I used the [Faker Gem](https://github.com/stympy/faker) along with it to load all the data.

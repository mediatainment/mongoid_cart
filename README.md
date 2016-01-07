#MongoidCart

Attempt to bring up the most basic shopping cart for mongoid.

## Features:

* Multiple Models can be put into cart
* CartController already setup
* current_cart view_helpers for cart
* able to set more than one cart (multiple wishlists) (@wip)

__@wip__ This project is still in progress!

Please feel free to contribute (Pull requests).

This project rocks and uses MIT-LICENSE.

## Usage:

Put this into your gemfile

    gem 'mongoid_cart'
    
Mount the cart engine and put this into your routes.rb

    mount MongoidCart::Engine => '/cart'

Now you have the CartController ready setup

Let's add the cart functions to your models (can be more than once).

    include MongoidCart::ActsAsProduct
    
    # Your model MUST HAVE the following fields:
    
    field :product_title, type: String # Title/Name of the product
    field :sku, type: String # unique Product ID
    field :net_price, type: Float # simple net price for item 
    field :units, type: Array # should provide an array with values for units 
    field :amount, type: Integer # amount of units in cart
    
Now your model has a few new methods like

- add_to_cart 
- remove_from_cart
- in_cart?
- in_stock?

If you wanna add or remove an item to the cart, simply put this into your view

    <%= add_or_remove_cart_link(your_model_instance) %>

    # or 
    
    <%= add_to_cart_link(your_model_instance) unless your_model_instance.in_cart? %>
    <%= remove_from_cart_link(your_model_instance) if your_model_instance.in_cart? %>
    
Your cart can be retrieved via ``current_cart``

Which retrieves an ``Set`` class (which is a unique Array)

    #<Set: {#<YourModel _id: 123456789012334556000000, created_at: 2015-12-31 00:23:17 UTC, updated_at: 2015-12-31 00:23:17 UTC, title: "Title 1", user_id: BSON::ObjectId('123123123123123123000001') >,
            #<YourModel _id: 123456789012334556000001, created_at: 2015-12-24 13:21:54 UTC, updated_at: 2015-12-24 13:44:47 UTC, title: "Title 2", user_id: BSON::ObjectId('123123123123123123000001')>
           }>

To show your cart, simply make a partial which iterates through the ``current_cart` items

    Example:
    
    <% current_cart.each do |item| %>   
        <%= link_to(item.title, item) %> 
    <% end %>
    
## Price calculation


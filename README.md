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
    
Now your model has a few new methods like

* add_to_cart 
* remove_from_cart
* in_cart?
* in_stock?

If you wann add an item to the cart, simply put this into your view

    <%= form_tag(mongoid_cart.remove_item_path(item: {type: cart_item.class.to_s, id: cart_item[:id]}), class: 'cart nobottommargin clearfix') do %>
       <%# render partial: "partials/shop/quantity" %>
       <%= submit_tag 'Remove from cart', class: 'btn btn-xs btn-error' %>
    <% end %>
    
    
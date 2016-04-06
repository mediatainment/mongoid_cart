# MongoidCart
## ActsAsProduct for Mongoid::Documents

Simple Mongoid based shopping cart. Every `Model` can get a Product to put into a cart. You simply need a User model and one or more models which should act as a product.
Tests are written in rSpec.

## Features:

* Multiple Models can be put into cart
* CartController already setup
* current_cart view_helpers for cart
* able to set more than one cart (multiple wishlists) (@wip)

__@wip__ This project is evolving and work in progress!
If you wanna use a most basic working version, you can nail down version 0.5. Use without version to stay on top.

Please feel free to contribute (Pull requests).

This project rocks and uses MIT-LICENSE.

## Usage:

Put this into your gemfile

    gem 'mongoid_cart'
    
Mount the cart engine and put this into your routes.rb
_(you can skip this, if you already have your cart_views)_

    mount MongoidCart::Engine => '/cart'

Now you have the CartController ready setup

Let's add the functionality to your model(s)
Yes, you can attach this to more than one! ;-)

    include MongoidCart::ActsAsProduct


With this line above your model will get new fields, relations and functions, you can override them in your model if you want, but they are present already:

    field :sku, type: String # unique Product ID
    field :product_title, type: String # Title/Name of the product
    field :net_price, type: Float # simple net price for item
    field :in_stock, type: Float # simple net price for item
    field :units, type: Array # must provide an array with values for units of product

    validates_presence_of :product_title, :net_price, :in_stock, :units

    has_many :cart_items
    carts # return all carts, where the product is used.

    type # returns the class_name as string. This will be used by MongoidCart to be able to fetch your products.
    cart # returns the cart.
    amount= # set the amount to add or reduce
    unit= # any unit of self.units
    to_cart_item_params #returns params prepared to add to a cart. Can also be used in views for example.


Attach User to be able to have carts

    include MongoidCart::ActsAsCustomer


This adds the following functions to your User.model

    current_cart # returns the very last cart or creates one
    carts # returns all carts of user

## relations automatically created

    +----------------+    +-------------------+   +----------------------+  +----------------------+
    |                |    |                   |   |                      |  |        Model 1       |
    |                |    |                   |   |                      |  |                      |
    |     User       |    |                   |   |                      |  |        Product       |
    | ActsAsCustomer +--> | MongoidCart::Cart <---+ MongoidCart::CartItem+-->     ActsAsProduct    |
    |                |    |                   |   |                      |  |                      |
    |                |    |                   |   |                      |  |                      |
    |                |    |                   |   |                      |  |                      |
    +----------------+    +-------------------+   +----------------------+  +----------------------+
                                                                         |
     has_many :carts       belongs_to :customer     belongs_to :cart     |   has_many :cart_items
                           has_many :cart_items     belongs_to :product  |   carts
                           products                 belongs_to :another_product
                           another_products                              |
                                                                         |  +----------------------+
                                                                         |  |       Model 2        |
                                                                         |  |                      |
                                                                         |  |    AnotherProduct    |
                                                                         --->    ActsAsProduct     |
                                                                            |                      |
                                                                            |                      |
                                                                            |                      |
                                                                            +----------------------+
                                                                                                                                                                  has_many :cart_items
                                                                                   carts


## Now you can use it like this:

Your cart can be retrieved via ``current_cart``


    # add one product to cart
    current_user.current_cart.add(Product.last)
    # increments product by one if already given
    current_user.current_cart.add(Product.last)

    (if unit is not set, it will always the first unit in `units` array)

    # increment product by n, and specific unit
    current_user.current_cart.add(AnotherProduct.first, 2, AnotherProduct.units.sample)

    # decrement product by one
    current_user.current_cart.remove(Product.last)

    # decrement product by n
    current_user.current_cart.remove(Product.last, n)
    current_user.current_cart.remove(Product.last, n, desired_unit)

To show your cart, simply make a partial which iterates through the ``current_cart` items

    Example:
    
    <% current_cart.each do |item| %>   
        <%= link_to(item.title, item) %> 
    <% end %>
    
## Price calculation

@wip


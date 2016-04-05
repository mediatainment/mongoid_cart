# Class for the MongoidCart

module MongoidCart
  class Cart
    include Mongoid::Document

    field :user_id, type: String

    belongs_to :customer, :inverse_of => :carts, :class_name => MongoidCart.configuration.customer_model_name

    has_many :cart_items, :inverse_of => :cart, :class_name => 'MongoidCart::CartItem'

    def products
      Product.in(id: cart_items.pluck(:product_id))
    end

    def add(product_object)
      cart_items.create!(product_object.to_cart_item_params)
    end

  end
end
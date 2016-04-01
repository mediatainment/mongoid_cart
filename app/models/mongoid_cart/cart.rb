# Class for the MongoidCart

module MongoidCart
  class Cart
    include Mongoid::Document

    field :user_id, type: String

    has_many :cart_items, :inverse_of => :cart, :class_name => 'MongoidCart::CartItem'
    belongs_to :customer, :inverse_of => :carts, :class_name => 'User'

  end
end
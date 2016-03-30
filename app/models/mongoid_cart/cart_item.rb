module MongoidCart
  class CartItem
    include Mongoid::Document

    field :type, type: String
    field :product_title, type: String
    field :sku, type: String
    field :amount, type: Integer
    field :net_price, type: Float
    field :unit, type: String

    belongs_to :mongoid_cart_cart, :class_name => 'MongoidCart::Cart'

    validates_presence_of :type, :product_title, :sku, :amount, :unit, :net_price

  end
end
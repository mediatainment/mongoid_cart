module MongoidCart
  class CartItem
    include Mongoid::Document

    field :type, type: String
    field :product_title, type: String
    field :sku, type: String
    field :amount, type: Integer
    field :net_price, type: Float
    field :unit, type: String

    belongs_to :cart, :inverse_of => :cart_items, :class_name => 'MongoidCart::Cart'

    validates_presence_of :product_title, :unit, :amount, :type, :net_price

  end
end
module MongoidCart
  class CartItem
    include Mongoid::Document

    field :type, type: String
    field :product_title, type: String
    field :sku, type: String
    field :amount, type: Integer
    field :net_price, type: Float
    field :unit, type: String

    attr_accessor :units, :in_stock

    belongs_to :cart, :class_name => 'MongoidCart::Cart', inverse_of: :cart_items

    validates_presence_of :type, :product_title, :sku, :amount, :unit, :net_price

    attr_accessor :amount, :unit
    def amount
      @amount || 1
    end

    def unit
      @unit || units.first
    end

  end
end
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

    def related_product
      self.send(self.type.underscore.to_sym)
    end

    def net_sum
      net_price * amount
    end

  end
end
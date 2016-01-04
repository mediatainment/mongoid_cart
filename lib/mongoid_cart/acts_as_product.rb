# This module can be included into your models
# include MongoidCart::ActsAsProduct
#
# Your model MUST HAVE the following fields:

#   field :title, type: String
#   field :sku, type: String
#   field :price, type: Float
#   field :units, type: Array


module MongoidCart
  module ActsAsProduct

    def add_to_cart
      MongoidCart::Cart.add_item(self)
    end

    def remove_from_cart
      MongoidCart::Cart.remove_item(self)
    end

    def in_cart?
      MongoidCart::Cart.in_cart?(self)
    end

    def in_stock?
      self.in_stock > 0
    end

  end
end
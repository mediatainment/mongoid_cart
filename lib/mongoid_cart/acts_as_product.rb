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
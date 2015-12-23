module MongoidCart
  module CartHelper

    def current_cart
      MongoidCart::Cart.current
    end

  end
end
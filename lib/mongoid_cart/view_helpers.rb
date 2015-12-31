module MongoidCart
  module ViewHelpers

    # is the current cart
    def current_cart
      MongoidCart::Cart.current
    end

    # fetches product record by given item
    def fetch_product(item)
      item[:type].constantize.find(item[:id])
    end

  end
end
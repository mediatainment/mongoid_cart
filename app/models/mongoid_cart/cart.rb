# Class for the MongoidCart

module MongoidCart
  class Cart

    def self.items
      @items ||= Set.new
    end

    def self.current
      MongoidCart::Cart.items
    end

    def self.add_item(item)
      #counts up if already there
      added = added?(item)
      unless added
        item_from_cart = MongoidCart::Cart.items.detect { |c_item| c_item[:id] == item._id }
        count_up_in_cart(item_from_cart)
      end
      # return the item
      added
    end


    # when product is marked as single_product only one item can be in the cart
    def self.count_up_in_cart(item_to_count_up)
      # check if item can be added twice
      if defined?(self.single_product) && self.single_product == true
        item_to_count_up[:amount] = 1
      else
        item_to_count_up[:amount] = (item_to_count_up[:amount] + 1) rescue 1
      end
    end

    def self.added?(item)
      MongoidCart::Cart.items.add?(item)
    end

    # removes item from cart
    def self.remove_item(item)
      self.current.delete_if do |cart_item|
        cart_item.class.to_s == item.class.to_s && cart_item._id == item._id
      end
    end

    def self.in_cart?(item)
      MongoidCart::Cart.current.include? item
    end
  end
end
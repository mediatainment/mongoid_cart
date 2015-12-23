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
      added = added?(item)
      #counts up if already there
      unless added
        item_to_count_up = MongoidCart::Cart.items.detect { |c_item| c_item[:id] == item._id }
        item_to_count_up[:amount] = (item_to_count_up[:amount] + 1) rescue 1
      end
      added
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

    def get_product(item)
      item[:type].constantize.find(item[:id])
    end

  end
end
module MongoidCart
  module CartHelper

    def current_cart
      session[:cart] ||= Set.new
    end

    # adds item to cart
    def add_to_cart(item)
      added = current_cart.add?(prepare_item_for_cart(item))
      #counts up if already there
      unless added
        item_to_count_up = current_cart.detect { |c_item| c_item[:id] == item._id }
        item_to_count_up[:units] = item_to_count_up[:units] + 1
      end
      added
    end

    # removes item from cart
    def remove_from_cart(item)
      current_cart.delete_if { |cart_item| cart_item[:type] == item.class.to_s && cart_item[:id] == item._id }
    end

    # extract item_id and item_type
    def prepare_item_for_cart(item)
      {type: item.class.to_s,
       id: item._id,
       units: 1}
    end
  end
end
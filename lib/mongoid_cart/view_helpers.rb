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

    # link_to mongoid_cart.remove_item_path
    def remove_from_cart_link(item)
      link_to(mongoid_cart.remove_item_path(item: {type: item.class.to_s, id: item._id}), {class: "btn btn-default"}) do
        (tag :i, class: 'fa fa-cart-plus').concat('Remove from cart')
      end
    end

    # link_to mongoid_cart.add_item_path
    def add_to_cart_link(item)
      link_to(mongoid_cart.add_item_path(item: {type: item.class.to_s, id: item._id}), {class: "btn btn-default"}) do
        (tag :i, class: 'fa fa-cart-plus').concat('Add to cart')
      end
    end

    # shows the add_to_cart or remove_from_cart link, depending if the item is already in cart or not
    def add_remove_cart_link(item)
     if item.in_cart?
       remove_from_cart_link item
     else
       add_to_cart_link item
     end
    end

  end
end
module MongoidCart
  module ViewHelpers

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
    def add_or_remove_cart_link(item)
      if current_cart.add item
        remove_from_cart_link item
      else
        add_to_cart_link item
      end
    end

    def link_to_product(item, *options)
      action = options.include?(:action) ? options[:action] : :show
      controller = options.include?(:controller) ? options[:controller] : item.type.pluralize.downcase

      link_to item.title, controller: controller, action: action, id: item.id
    end

    # sums net_price of cart contentç
    def sum
      self.current.map { |item| [item.amount, item.net_price] }
    end

  end
end
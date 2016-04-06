# Class for the MongoidCart

module MongoidCart
  class Cart
    include Mongoid::Document

    field :user_id, type: String

    belongs_to :customer, :inverse_of => :carts, :class_name => MongoidCart.configuration.customer_model_name

    has_many :cart_items, :inverse_of => :cart, :class_name => 'MongoidCart::CartItem'

    validates_with MongoidCart::Validators::CartItemDuplicateValidator

    # given Hash or MongoidCart::ActsAsProduct instance will be added to current_cart
    # @return
    def add(product_object, amount=nil, unit=nil)
      product_object = (product_object)
      product_object.amount = amount if amount
      product_object.unit = unit if unit
      cart_item_params = product_object.to_cart_item_params

      existing_item = find_item(cart_item_params)

      unless existing_item
        cart_items.create!(cart_item_params)
      else
        existing_item.inc(amount: cart_item_params[:amount])
      end
    end

    # searches cart_items by a given Hash or MongoidCart::ActsAsProduct instance
    def find_item(item)
      return nil if cart_items.blank?

      item = prepare_for_cart_item(item)
      return cart_items.detect do |ci|
        ci.type == item.type && ci.unit == item.unit
      end
    end

    # given Hash or MongoidCart::ActsAsProduct instance will be prepared to store as cart_item
    # @return MongoidCart::ActsAsProduct instance
    def prepare_for_cart_item(item)
      is_a_hash = item.is_a? Hash
      if is_a_hash
        prepared_item = MongoidCart::CartItem.new item

      elsif item.singleton_class.included_modules.include?(MongoidCart::ActsAsProduct)
        prepared_item = item

      else
        raise StandardError, "Given object must be a Hash or include MongoidCart::ActsAsProduct: #{item.class}"
      end


      return prepared_item
    end
  end
end
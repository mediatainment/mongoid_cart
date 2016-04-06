module MongoidCart
  class Relation

    # creates a string which can be implemented in models to provide dynamcic relation
    def self.cart_items_product_string(class_name)
      "belongs_to :#{class_name.to_s.underscore.to_sym}" + ", :class_name => '#{class_name.constantize}', inverse_of: :cart_item"
    end

    def self.build_user_relation_string
      "has_many :carts, :class_name => 'MongoidCart::Cart', inverse_of: :customer"
    end

    def self.cart_product_string(class_name)
      "def #{class_name.to_s.underscore.pluralize}; #{class_name.camelcase.constantize}.in(id: cart_items.pluck(:#{class_name.to_s.underscore}_id)); end"
    end

  end
end
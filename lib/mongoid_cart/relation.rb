module MongoidCart
  class Relation

    # creates a string which can be implemented in models to provide dynamcic relation
    def self.build_product_relation_string(class_name)
      "belongs_to "+ ":#{class_name.to_s.underscore.to_sym}" + ", :class_name => '#{class_name.constantize}', inverse_of: :cart_item"
    end

  end
end
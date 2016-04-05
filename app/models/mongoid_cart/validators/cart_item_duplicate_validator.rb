module MongoidCart
  module Validators
    class CartItemDuplicateValidator < ActiveModel::Validator

      def validate(record)
        cart_items = record.cart_items

        existing_duplicate = cart_items.detect do |ci|
          ci.type == record.type && ci.unit == record.unit
        end

        if existing_duplicate
          existing_duplicate
          return false
        end

      end
    end
  end
end
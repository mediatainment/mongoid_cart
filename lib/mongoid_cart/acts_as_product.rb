# This module should be included into your models via
# include into MongoidCart::ActsAsProduct
#
require 'active_support/concern'

module MongoidCart
  module ActsAsProduct
    extend ActiveSupport::Concern

    included do

      has_and_belongs_to_many :cart_items, :class_name => 'MongoidCart::CartItem'

      attr_accessor :amount, :unit

      validates_presence_of :product_title, :net_price, :in_stock

      # returns Hash with mapped cart_item params
      def cart_item_params
        {product_title: self.product_title,
         unit: self.unit,
         amount: self.amount,
         type: self.type,
         net_price: self.net_price
        }
      end

      def type
        self.class.to_s
      end

    end

    module ClassMethods

    end

  end
end
# This module should be included into your models via
# include into MongoidCart::ActsAsProduct
#
require 'active_support/concern'

module MongoidCart
  module ActsAsCustomer
    extend ActiveSupport::Concern

    included do

      # a method which provides a customer_id
      attr_accessor :customer_id, :current_cart

      has_many :carts, :class_name => 'MongoidCart::Cart', inverse_of: :customer

      def customer_id
        @customer_id ||= self.object_id.to_s
      end

      def current_cart
        carts.last || carts.new
      end
    end

    module ClassMethods

    end

  end

end
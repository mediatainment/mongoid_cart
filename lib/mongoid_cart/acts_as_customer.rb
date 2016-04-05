# This module should be included into your models via
# include into MongoidCart::ActsAsProduct
#
require 'active_support/concern'

module MongoidCart
  module ActsAsCustomer
    extend ActiveSupport::Concern

    included do

      # a method which provides a customer_id
      attr_accessor :current_cart
      has_many :carts, :class_name => 'MongoidCart::Cart', inverse_of: :customer

      def current_cart
        carts.last || carts.create
      end
    end

    module ClassMethods

    end

  end

end
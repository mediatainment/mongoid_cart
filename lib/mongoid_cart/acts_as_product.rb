# This module should be included into your models via
# include into MongoidCart::ActsAsProduct
#
require 'active_support/concern'

module MongoidCart
  module ActsAsProduct
    extend ActiveSupport::Concern

    included do

      # adds dynamic association to the CartItem to refer to the ActsAsProduct class
      cart_item_relation_method = MongoidCart::Relation.cart_items_product_string(name)
      MongoidCart::CartItem.class_eval(cart_item_relation_method)

      # set relations
      has_many :cart_items,
               class_name: "MongoidCart::CartItem",
               as: class_name_to_sym,
               inverse_of: :product

      def carts
        MongoidCart::Cart.in(id: cart_items.pluck(:cart_id))
      end

      # sku
      field :sku, type: String

      # product_title / name of your product
      field :product_title, type: String

      # how many the item cost without any taxes
      field :net_price, type: Float, default: 0.0

      # how many products are in stock
      field :in_stock, type: Float, default: 0

      # returns an array with units
      field :units, type: Array

      attr_accessor :unit, :amount

      validates_presence_of :product_title, :net_price, :in_stock, :units

      before_create :assign_sku

      # a method which provides a product sku like
      # PN-aec5d-00002

      def build_sku
        "#{self.product_title.split(' ').map(&:first).map!(&:upcase).join}-#{_id.to_s.split(//).first(5).join}-#{_id.to_s.split(//).last(5).join}"
      end

      # returns Hash with mapped cart_item params
      def to_cart_item_params
        {product_id: self.id,
         sku: self.sku,
         product_title: self.product_title,
         type: self.type,
         in_stock: self.in_stock,
         net_price: self.net_price,
         units: self.units,
         unit: self.unit,
         amount: self.amount
        }
      end

      # returns class of product as String
      def type
        self.class.to_s
      end

      private

      def assign_sku
        self.sku = build_sku
      end

    end

    module ClassMethods

      def class_name_to_sym
        name.underscore.to_sym
      end
    end

  end

end
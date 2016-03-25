class Product
  include Mongoid::Document
  include MongoidCart::ActsAsProduct

  # product_title / name of your product
  field :product_title, type: String

  # how many the item cost without any taxes
  field :net_price, type: Float, default: 0.0

  # how many products are in stock
  field :in_stock, type: Float, default: 0

  # this field simple provides an Array with units in Strings
  field :units, type: Array

  attr_accessor :product_title, :net_price, :in_stock, :unit, :sku, :cart_item

  has_many :cart_items, class_name: "MongoidCart::CartItem", inverse_of: :product

  # a method which provides a product sku like
  # PN-aec5d-00002
  #
  def sku
    "#{self.product_title.split(' ').map(&:first).map!(&:upcase).join}-#{_id.to_s.split(//).first(5).join}-#{_id.to_s.split(//).last(5).join}"
  end

end


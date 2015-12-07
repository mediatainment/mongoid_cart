class Product
  include Mongoid::Document

  field :name, type: String
  field :sku, type: String
  field :stock, type: Float
  field :net_price, type: Float

  validates_presence_of :name, :net_price
end


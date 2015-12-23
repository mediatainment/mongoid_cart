class Product
  include Mongoid::Document
  include MongoidCart::ActsAsProduct

  field :name, type: String
  field :sku, type: String
  field :in_stock, type: Float
  field :net_price, type: Float
  field :units, type: Array

end


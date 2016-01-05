class Product
  include Mongoid::Document
  include MongoidCart::ActsAsProduct

  field :title, type: String
  field :sku, type: String
  field :net_price, type: Float
  field :amount, type: Integer
  field :unit, type: String
  field :units, type: Array
  field :in_stock, type: Float

end


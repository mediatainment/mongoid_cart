class Product
  include Mongoid::Document
  include MongoidCart::ActsAsProduct

end


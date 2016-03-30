class User
  include Mongoid::Document
  field :email, type: String
  field :password, type: String

  has_many :carts, :class_name => 'MongoidCart::Cart', inverse_of: :user
end

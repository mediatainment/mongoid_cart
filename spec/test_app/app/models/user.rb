class User
  include Mongoid::Document

  include MongoidCart::ActsAsCustomer

  field :email, type: String
  field :password, type: String

  validates_presence_of :email, :password
end

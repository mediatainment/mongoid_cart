# Class for the MongoidCart

module MongoidCart
  class Cart

    include Mongoid::Document

    field :user_id, type: String

  end
end
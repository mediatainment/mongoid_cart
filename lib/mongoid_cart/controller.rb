module MongoidCart
  module Controller
    extend ActiveSupport::Concern

    def cart_id
      session[:mongoid_cart_id] ||= MongoidCart::Cart.create._id
    end

    def current_cart
      session[:mongoid_current_cart] ||= MongoidCart::Cart.find cart_id
    end
  end
end
require 'rails'
require 'mongoid_cart'
require 'mongoid_cart/controller'
require 'mongoid_cart/view_helpers' if defined? ActionView

module MongoidCart
  class Railtie < Rails::Railtie

    initializer "mongoid_cart.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        include MongoidCart::Controller
      end
    end

    initializer "mongoid_cart.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
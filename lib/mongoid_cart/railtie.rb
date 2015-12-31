require 'rails'
require 'mongoid_cart'
require 'mongoid_cart/view_helpers' if defined? ActionView

module MongoidCart
  class Railtie < Rails::Railtie
    initializer "mongoid_cart.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
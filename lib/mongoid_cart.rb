require "mongoid_cart/engine"
require 'mongoid_cart/railtie' if defined?(Rails)
require "mongoid_cart/acts_as_product"
require 'mongoid_cart/relation'

module MongoidCart

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :customer_model_name

    def initialize
      @customer_model_name = 'User'
    end
  end
end

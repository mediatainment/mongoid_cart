require 'rails_helper'

describe MongoidCart::CartHelper do
  describe 'current_cart' do
    it "is a Set" do
      helper.current_cart.is_a? Set
    end
  end
end
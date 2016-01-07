require 'rails_helper'

describe MongoidCart::Cart do

  describe 'add' do
    before(:each) do
      @product = create :product
      @cart = MongoidCart::Cart.new
    end

    it "should add new cart_items" do

    end
  end

end
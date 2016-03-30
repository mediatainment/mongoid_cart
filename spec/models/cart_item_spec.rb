require 'rails_helper'

describe MongoidCart::CartItem do

  describe 'add' do
    before(:each) do
      @cart = MongoidCart::CartItem.new
    end

    it "has relation to product" do
      is_expected.to belong_to(:product).of_type(Product).as_inverse_of(:cart_item)
    end
  end

end
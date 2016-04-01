require 'rails_helper'

describe MongoidCart::CartItem do

  describe 'relations' do
    before(:each) do
      @cart_item = MongoidCart::CartItem.new
    end

    it "belongs_to :product" do
      is_expected.to belong_to(:product).of_type(Product).as_inverse_of(:cart_item)
    end

    it 'belongs_to :another_product' do
      is_expected.to belong_to(:another_product).of_type(AnotherProduct).as_inverse_of(:cart_item)
    end
  end

end
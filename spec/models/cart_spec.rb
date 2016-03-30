require 'rails_helper'

describe MongoidCart::Cart do

  describe 'relations' do

    before(:each) do
      @product = create(:product)
      @user = create(:user)
    end

    it "belongs to User" do
      is_expected.to belong_to(:user).of_type(User).as_inverse_of(:carts)
    end


    it 'has_many cart_items' do
      is_expected.to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:cart)
    end
  end
end
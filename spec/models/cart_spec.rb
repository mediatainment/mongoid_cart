require 'rails_helper'

describe MongoidCart::Cart do

  describe "current_cart" do

    before(:each) do
      @products = FactoryGirl.create_list(:product, 10)
      @users = create_list(:user, 2)
      @user = @users.last
    end

    it 'carts are initially empty' do
      expect(@user.carts).to be_empty
    end

    it 'should return a MongoidCart::Cart' do
      expect(@user.current_cart).to be_an_instance_of(MongoidCart::Cart)
    end

    it 'adds new cart to user when called' do
      @user.current_cart

      expect(@user.carts.size).to be(1)
    end

    it 'should assign user_id to customer_id' do
      @user.current_cart

      expect(@user.carts.last.customer_id).to eql @user._id
    end
  end

  describe 'persistence' do
    before(:each) do
      @user = create(:user)
      @product = create(:product)
    end

    it 'should save cart_item when product given' do
      @user.current_cart.add @product

      expect(@user.current_cart.cart_items).to include
    end


  end

  describe 'relations' do

    before(:each) do
      @product = create(:product)
      @user = create(:user)
    end

    it "belongs to User" do
      is_expected.to belong_to(:customer).of_type(User).as_inverse_of(:carts)
    end

    it 'has_many cart_items' do
      is_expected.to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:cart)
    end
  end
end
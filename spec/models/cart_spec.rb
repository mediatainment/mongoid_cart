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

  describe 'find_item' do

    before :each do
      @cart = create :cart
      @product = create :product, amount: 1
    end

    specify 'given Hash returns MongoidCart::CartItem' do
      @cart.cart_items.create!(@product.to_cart_item_params)
      hash = @product.to_cart_item_params

      expect(@cart.find_item(hash)).to be_an_instance_of MongoidCart::CartItem
    end

    specify 'given Product returns MongoidCart::CartItem' do
      @cart.cart_items.create!(@product.to_cart_item_params)

      expect(@cart.find_item(@product)).to be_an_instance_of MongoidCart::CartItem
    end

  end

  describe 'validation' do

    before :each do
      @cart = create :cart
      @product = create :product, amount: 1
    end

    it 'already_in_cart? returns true if product matches' do
      @cart.add(@product)

      expect(@cart.find_item(@product)).to be_truthy
    end

    it 'keeps cart_items unique in cart' do
      @cart.add(@product)
      @cart.add(@product)

      expect(@cart.cart_items.size).to eql 1
    end

    it 'does increase automatically by one' do
      @cart.add(@product)
      @cart.add(@product)

      expect(@cart.cart_items.first.amount).to eql 2
    end

    it 'increases existing cart_item by given amount' do
      @cart.add(@product, 5)
      @cart.add(@product, 10)

      expect(@cart.cart_items.first.amount).to eql 15
    end

    it 'allows to add same item in another unit' do
      @cart.add(@product, 1, @product.units.last)
      @cart.add(@product, 1, @product.units.first)

      expect(@cart.cart_items.size).to eql 2
    end

  end

  describe 'persistence' do

    before(:each) do
      @user = create(:user)
      @product = create(:product)
    end

    it 'save cart_item by given product' do
      @user.current_cart.add @product

      expect(@user.current_cart.cart_items).to include
    end

    it 'overrides amount by add(product,n)' do
      expected_amount = 1000
      cart = @user.current_cart

      cart.add(@product, expected_amount)

      expect(User.last.current_cart.cart_items.last.amount).to eq expected_amount
    end

    it 'overrides unit if passed by add(product, n, unit)' do
      expected_unit = @product.units.sample
      cart = @user.current_cart

      cart.add(@product, @product.amount, expected_unit)

      expect(User.last.current_cart.cart_items.last.unit).to eq expected_unit
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
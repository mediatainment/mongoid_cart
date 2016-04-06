require 'rails_helper'

describe MongoidCart::Cart do


  describe 'calculations' do
    before(:each) do
      @cart = create :cart
    end

    it 'should sum net_price of all cart items' do
      product1 = create :product, net_price: 20, unit: "g"
      product2 = create :product, net_price: 10, unit: "kg"

      @cart.add(product1, 2) # 2 x 20 = 40
      @cart.add(product2, 2) # 2 x 10 = 20

      expect(@cart.cart_items.size).to eql 2
      expect(@cart.net_sum).to eql 60.0
    end
  end

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

  describe 'add products' do
    before :each do
      @cart = create :cart
      @product = create :product, amount: 1
    end

    it 'should add an cart_item' do
      expect(MongoidCart::CartItem.all.count).to be 0
      @cart.add @product
      expect(MongoidCart::CartItem.all.count).to be 1
    end

  end

  describe 'remove products' do

    before :each do
      @cart = create :cart
      @product = create :product, amount: 1
    end

    it 'should remove an cart_item' do
      @cart.add @product
      @cart.remove @product
      expect(MongoidCart::CartItem.count).to be 0
    end

    it 'should increase from cart_item' do
      @cart.add @product, 3
      @cart.remove @product, 1
      expect(MongoidCart::CartItem.last.amount).to be 2
    end

    it 'should remove from cart if lower than 0' do
      @cart.add @product, 3
      @cart.remove @product, 5
      expect(MongoidCart::CartItem.count).to be 0
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
      @another_product = create(:another_product)
    end

    it 'save cart_item by given product' do
      @user.current_cart.add @product

      expect(MongoidCart::CartItem.count).to be 1
    end

    it 'save cart_item by given another_product' do
      @user.current_cart.add @another_product

      expect(MongoidCart::CartItem.count).to be 1
    end

    it 'adds both product types' do
      cart = @user.current_cart

      cart.add @product
      cart.add @another_product

      expect(cart.cart_items.count).to eql 2
    end

    it 'adds by -ding' do
      @product2 = create :product, unit: "test"
      cart = create :cart

      cart.add @product
      cart.add @product2

      expect(cart.cart_items.size).to eql 2
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

    it 'decreases value if negative given' do
      @user.current_cart.add @product, 10
      @user.current_cart.add @product, -2

      expect(@user.current_cart.cart_items.last.amount).to eql 8
    end

  end

  describe 'relations' do

    before(:each) do
      @product = create(:product)
      @another_product = create(:another_product)
      @cart = create(:cart)
      @user = create(:user)
    end

    it "belongs to User" do
      is_expected.to belong_to(:customer).of_type(User).as_inverse_of(:carts)
    end

    it 'has_many cart_items' do
      is_expected.to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:cart)
    end

    it 'returns all products' do
      @user.current_cart.add(@product)

      expect(@user.current_cart.products).to include @product
    end

    it 'returns all another_products' do
      @user.current_cart.add(@another_product)

      expect(@user.current_cart.another_products).to include @another_product
    end

    it 'should return both product models independently' do
      @user.current_cart.add(@another_product)
      @user.current_cart.add(@product)

      cart = @user.current_cart
      expect(cart.cart_items.size).to be 2
      expect(cart.products.count).to be 1
      expect(cart.another_products.count).to be 1
    end

  end
end
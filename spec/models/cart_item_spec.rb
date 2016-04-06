require 'rails_helper'

describe MongoidCart::CartItem do

  describe 'relations' do

    before(:each) do
      @cart_item = MongoidCart::CartItem.new
    end

    it 'belongs_to :product' do
      is_expected.to belong_to(:product).of_type(Product).as_inverse_of(:cart_item)
    end

    it 'belongs_to :another_product' do
      is_expected.to belong_to(:another_product).of_type(AnotherProduct).as_inverse_of(:cart_item)
    end

    it 'belongs_to cart' do
      is_expected.to belong_to(:cart).of_type(MongoidCart::Cart).as_inverse_of(:cart_items)
    end

  end

  describe 'methods' do

    context 'sum' do

      specify 'amount by net_price with integer' do
        cart_item = create :cart_item, :with_product,{ net_price: 10.0, amount: 42}

        expect(cart_item.net_sum).to eql 420.0
      end
    end

    context 'related_product with product' do

      before(:each) do
        @cart_item = create :cart_item, :with_product
        @product = create :product
        @another_product = create :another_product
      end

      it 'responds with product' do
        cart = @cart_item.cart
        cart.add @product

        expect(@cart_item.product).to be_an_instance_of Product
      end

      it 'related_product responds with Product' do
        @cart_item.cart.add @product

        expect(@cart_item.related_product).to be_an_instance_of Product
      end
    end

    context 'related_product with another_product' do

      before :each do
        @cart_item = create :cart_item, :with_another_product
        @another_product = create :another_product
      end

      it 'related_product responds with AnotherProduct' do
        @cart_item.cart.add @another_product

        expect(@cart_item.related_product).to be_an_instance_of AnotherProduct
      end

      it 'responds with another_product' do
        cart = @cart_item.cart
        cart.add @another_product

        expect(@cart_item.another_product).to be_an_instance_of AnotherProduct
      end
    end
  end

  describe 'init' do

    specify 'with given Product' do
      product = FactoryGirl.create :product
      cart_item = MongoidCart::CartItem.new(product.to_cart_item_params)
      cart_item.amount = 1

      expect(cart_item.save!).to be_truthy
    end

    specify 'with given AnotherProduct' do
      product = FactoryGirl.create :another_product
      cart_item = MongoidCart::CartItem.new(product.to_cart_item_params)
      cart_item.amount = 1
      expect(cart_item.save).to be_truthy
    end
  end
end
require 'rails_helper'

describe MongoidCart::ActsAsProduct, type: :model do

  before :each do
    @product = create :product
  end

  describe 'validations' do

    it 'validate presence of product_title' do
      expect(@product).to validate_presence_of(:product_title)
    end

    it 'validate presence of net_price' do
      expect(@product).to validate_presence_of(:net_price)
    end

    it 'validate presence of in_stock' do
      expect(@product).to validate_presence_of(:in_stock)
    end

    it 'validate presence of units' do
      expect(@product).to validate_presence_of(:units)
    end

  end

  describe 'relations' do
    before(:each) do
      @product = Product.new
      @another_product = AnotherProduct.new
    end

    it 'should have_many :cart_items on product' do
      expect(@product).to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:product)
    end

    it 'should have_many :cart_items on another_product' do
      expect(@another_product).to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:product)
    end

  end

  describe 'fields' do

    describe 'type' do

      it 'should return the class as string' do
        expect(@product.type).to eq Product.to_s
      end
    end
  end

  describe 'cart_item_params' do

    it 'should return Hash with mapped params' do
      result = {sku: @product.sku,
                product_title: @product.product_title,
                type: @product.class.to_s,
                net_price: @product.net_price,
                in_stock: @product.in_stock,
                unit: @product.unit,
                amount: @product.amount,
                units: @product.units
      }

      expect(@product.cart_item_params).to eq result
    end

  end

end
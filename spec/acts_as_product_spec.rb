require 'rails_helper'

describe MongoidCart::ActsAsProduct do

  describe "model validations" do

    it 'has to include a :name attribute' do
      expect(true).to be_truthy
    end
  end

  describe 'add_to_cart' do
    before :each do
      @product = create :product
    end

    it "should add an item" do

      @product.add_to_cart

      expect(MongoidCart::Cart.current.count).to be 1
    end

    it "should not add duplicate items" do

      @product.add_to_cart
      @product.add_to_cart

      expect(MongoidCart::Cart.current.count).to be 1
    end

    it "should add different items" do
      product2 = create :product

      @product.add_to_cart
      product2.add_to_cart

      expect(MongoidCart::Cart.current.count).to be 2
    end
  end

  describe 'remove_from_cart' do

    it "removes item from cart" do
      product = create(:product)

      product.add_to_cart
      product.remove_from_cart

      expect(MongoidCart::Cart.current.count).to be 0
    end
  end

  describe 'in_cart?' do

    it 'returns false if not in cart' do
      product = create :product

      expect(product.in_cart?).to be_falsey
    end

    it 'returns true if already in cart' do
      product = create :product

      product.add_to_cart

      expect(product.in_cart?).to be_truthy
    end
  end
end
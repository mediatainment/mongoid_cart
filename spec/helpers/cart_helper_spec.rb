require 'rails_helper'

describe MongoidCart::CartHelper do
  describe 'current_cart' do
    it "is a Set" do
      helper.current_cart.is_a? Set
    end
  end

  describe 'prepare_item_for_cart' do

    it 'returns a hash' do
      product = create(:product)
      prepared_item = helper.prepare_item_for_cart(product)
      expect(prepared_item).to be_an Hash
    end

    it 'contains id, type and units' do
      product = create(:product)
      prepared_item = helper.prepare_item_for_cart(product)
      expect(prepared_item).to include(:units, :id, :type)
    end
  end

  describe 'add_to_cart' do
    it 'adds a item to cart' do
      product = create(:product)
      cart = helper.add_to_cart(product)
      expect(cart.count).to be 1
    end

    it 'adds a second item to cart' do
      product = create(:product)
      product2 = create(:product)
      helper.add_to_cart(product)
      cart = helper.add_to_cart(product2)
      expect(cart.count).to be 2
    end

    it 'dont adds items twice' do
      product = create(:product)
      helper.add_to_cart(product)
      cart = helper.add_to_cart(product)
      expect(cart.count).to be 1
    end

    it 'increments item count' do
      product = create(:product)
      helper.add_to_cart(product)
      helper.add_to_cart(product)
      expect(current_cart.first[:units]).to be 2
    end

  end

  describe 'remove_from_cart' do

    it 'removes item from cart' do
      product = create(:product)

      helper.add_to_cart(product)
      helper.remove_from_cart(product)
      expect(helper.current_cart.count).to be 0
    end

  end
end
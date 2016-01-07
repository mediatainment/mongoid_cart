require 'rails_helper'

describe MongoidCart::ActsAsProduct, type: :model do

  before :each do
    @product = create :product
  end

  describe 'validations' do

    it 'validate presence of sku' do
      expect(@product).to validate_presence_of(:sku)
    end
    it 'validate presence of title' do
      expect(@product).to validate_presence_of(:title)
    end
    it 'validate presence of net_price' do
      expect(@product).to validate_presence_of(:net_price)
    end
    it 'validate presence of amount' do
      expect(@product).to validate_presence_of(:amount)
    end
    it 'validate presence of type' do
      expect(@product).to validate_presence_of(:type)
    end
    it 'validate presence of unit' do
      expect(@product).to validate_presence_of(:unit)
    end
    it 'validate presence of in_stock' do
      expect(@product).to validate_presence_of(:in_stock)
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
      result = {title: @product.title,
                unit: @product.unit,
                amount: @product.amount,
                type: @product.class.to_s,
                net_price: @product.net_price}

      expect(@product.cart_item_params).to eq result
    end
  end
end
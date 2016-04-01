require 'rails_helper'

describe Product, type: :model do

  before(:each) do
    @product = create :product
    @another_product = create :another_product
  end

  it 'has a relation to MongoidCart::CartItem' do
    is_expected.to have_many(:cart_items).of_type(MongoidCart::CartItem).as_inverse_of(:product)
  end

end
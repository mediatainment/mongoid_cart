require 'rails_helper'

describe MongoidCart::ActsAsCustomer, type: :model do

  before :each do
    @user = create :user
  end

  describe 'relations' do
    before(:each) do
      @user = User.new
    end

    it 'should have_many :carts' do
      expect(@user).to have_many(:carts).of_type(MongoidCart::Cart).as_inverse_of(:customer)
    end

  end

end
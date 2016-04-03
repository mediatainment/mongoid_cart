require 'rails_helper'

RSpec.describe User, type: :model do

  context 'relations' do
    before(:each) do
      @user = create :user
    end

    it "should have_many carts" do
      expect(@user).to have_many(:carts).of_type(MongoidCart::Cart).as_inverse_of(:customer)
    end

  end

end

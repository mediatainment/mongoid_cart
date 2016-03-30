require 'rails_helper'

describe MongoidCart::Cart do

  describe 'add' do

    before(:each) do
      @product = create(:product)
      @user = create(:user)
    end

    it "has relation to user" do
      is_expected.to belong_to(:user).of_type(User).as_inverse_of(:carts)
    end
  end
end
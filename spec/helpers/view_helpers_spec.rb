require 'rails_helper'

describe MongoidCart::ViewHelpers do

  describe 'remove_from_cart_link' do
    before(:each) do
      @product = create :product
    end

    it 'should provide a link to remove the item from cart' do
      skip
      expect(helper.remove_from_cart_link(@product)).to have_selector(:content => 'link text')
    end
  end

  describe 'link_helpers' do

    before(:each) do
      @product = create :product
      @mongoid_cart_remove_item_path = mongoid_cart.remove_item_path(item: {type: @product.class.to_s, id: @product._id})
      @mongoid_cart_add_item_path = mongoid_cart.add_item_path(item: {type: @product.class.to_s, id: @product._id})
    end

    specify 'add_to_cart_link should provide a link to add the item from cart' do

      expect(helper.add_to_cart_link(@product)).to have_selector("a[href='#{@mongoid_cart_add_item_path}']",
                                                                 :text => "Add to cart")
    end

    specify 'remove_from_cart_link should provide a link to remove the item from cart' do
      expect(helper.remove_from_cart_link(@product)).to have_selector("a[href='#{@mongoid_cart_remove_item_path}']",
                                                                      :text => "Remove from cart")
    end

    specify 'add_or_remove_cart_link should return remove link when already in cart' do
      skip
      helper.current_cart.add(@product)

      expect(helper.add_or_remove_cart_link(@product)).to have_selector("a[href='#{@mongoid_cart_remove_item_path}']",
                                                                        :text => "Remove from cart")

    end

    specify 'add_or_remove_cart_link should return add link when not in cart' do
      skip
      expect(helper.add_or_remove_cart_link(@product)).to have_selector("a[href='#{@mongoid_cart_add_item_path}']",
                                                                        :text => "Add to cart")
    end


  end
end
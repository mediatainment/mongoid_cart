require 'rails_helper'

RSpec.describe "products/index", :type => :view do

  before(:each) do
    @products = assign(:products, [create(:product), create(:product)])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => @products.first.product_title.to_s, :count => 1
    assert_select "tr>td", :text => @products.last.product_title.to_s, :count => 1
    assert_select "tr>td", :text => @products.first.sku.to_s, :count => 1
    assert_select "tr>td", :text => @products.last.sku.to_s, :count => 1
    assert_select "tr>td", :text => @products.first.in_stock.to_s, :count => 2
    assert_select "tr>td", :text => @products.last.in_stock.to_s, :count => 2
  end
end

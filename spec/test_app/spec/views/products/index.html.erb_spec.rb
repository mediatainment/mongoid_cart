require 'rails_helper'

RSpec.describe "products/index", :type => :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :product_title => "Title",
        :amount => 5,
        :in_stock => 1.5,
        :net_price => 1.5
      ),
      Product.create!(
        :product_title => "Title",
        :amount => 5,
        :in_stock => 1.5,
        :net_price => 1.5
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 4
  end
end

require 'rails_helper'

RSpec.describe "products/new", :type => :view do
  before(:each) do
    assign(:product, Product.new(
      :name => "MyString",
      :sku => "MyString",
      :in_stock => 1.5,
      :net_price => 1.5
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_sku[name=?]", "product[sku]"

      assert_select "input#product_in_stock[name=?]", "product[in_stock]"

      assert_select "input#product_net_price[name=?]", "product[net_price]"
    end
  end
end

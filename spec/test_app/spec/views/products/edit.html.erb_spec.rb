require 'rails_helper'

RSpec.describe "products/edit", :type => :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "MyString",
      :sku => "MyString",
      :in_stock => 1.5,
      :net_price => 1.5
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_sku[name=?]", "product[sku]"

      assert_select "input#product_in_stock[name=?]", "product[in_stock]"

      assert_select "input#product_net_price[name=?]", "product[net_price]"
    end
  end
end

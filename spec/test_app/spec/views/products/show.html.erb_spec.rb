require 'rails_helper'

RSpec.describe "products/show", :type => :view do

  before(:each) do
    @product = assign(:product, create(:product))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Sku/)
    expect(rendered).to match(/Net price/)
    expect(rendered).to match(/In Stock/)
  end
end

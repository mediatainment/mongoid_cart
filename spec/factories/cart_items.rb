FactoryGirl.define do

  valid_units = %w{kg lt m pkg oz ml}

  factory :cart_item, class: "MongoidCart::CartItem" do
    sequence(:sku) {|x| "PRODUCT-#{x}-SKU"}
    sequence(:product_title) {|x| "Product Title #{x}"}
    amount (1..100).to_a.sample
    unit valid_units.sample
    type "Product"
    net_price (1..10000).to_a.sample
    cart
  end
end
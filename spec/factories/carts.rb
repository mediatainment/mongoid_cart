FactoryGirl.define do

  valid_units = %w{kg lt m pkg oz ml}

  factory :cart do
    type "Product"
    sequence(:product_title) { |n| "Product Title #{n}" }
    sequence(:sku) { |n| "SKU-#{n}-STRING" }
    amount (1..100).to_a.sample
    net_price (1..10000).to_a.sample
    unit valid_units.sample
    units valid_units
    customer
  end
end
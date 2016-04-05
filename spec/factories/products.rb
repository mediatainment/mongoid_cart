FactoryGirl.define do

  valid_units = %w{kg lt m pkg oz ml}
  factory :product do
    sequence(:product_title) { |n| "Product Name#{n}" }
    net_price 99
    in_stock (1..100).to_a.sample
    units valid_units
    unit valid_units.sample
    amount (1..10).to_a.sample
    factory :another_product, class: AnotherProduct do
    end
  end


end
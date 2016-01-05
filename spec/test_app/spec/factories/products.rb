# This will guess the User class
FactoryGirl.define do

  factory :product do
    sequence(:title) { |n| "Product Name#{n}" }
    sequence(:sku) { |n| "PRODUCT-0#{n}" }
    net_price 99
    amount 10
    in_stock 100
    units %w{1000 100 10 0.1 0.25}.sample()
    unit %w{kg lt m pkg oz ml}.sample()
  end
end
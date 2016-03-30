# This will guess the User class
FactoryGirl.define do

  factory :product do
    sequence(:product_title) { |n| "Product Name#{n}" }
    net_price 99
    in_stock (1..100).to_a.sample
    units %w{kg lt m pkg oz ml}
  end
end
# This will guess the User class
FactoryGirl.define do

  factory :product do
    sequence(:name) { |n| "Product Name#{n}" }
    sequence(:sku) { |n| "PRODUCT-0#{n}" }
    stock '100'
    net_price '10'
  end
end
# This will guess the User class
FactoryGirl.define do

  factory :product do
    name "Product Name"
    sku  "PROD-NAME-001"
    stock '100'
    net_price '10'
  end
end
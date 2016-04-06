FactoryGirl.define do

  valid_units = %w{kg lt m pkg oz ml}

  factory :cart_item, class: "MongoidCart::CartItem" do
    sequence(:sku) { |x| "PRODUCT-#{x}-SKU" }
    sequence(:product_title) { |x| "Product Title #{x}" }
    amount (1..100).to_a.sample
    unit valid_units.sample
    net_price (1..10000).to_a.sample
    cart
    trait :with_product do
      type "Product"
      product
    end
    trait :with_another_product do
      type "AnotherProduct"
      another_product
    end
  end
end
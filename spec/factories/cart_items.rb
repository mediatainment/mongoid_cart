FactoryGirl.define do

  factory :cart_item, class: "MongoidCart::CartItem" do
    sequence(:product_title) {|x| "Product Title #{x}"}
    amount 10
    unit %w{kg ml lt oz}.sample
    type "Product"
    net_price 123.45
  end
end
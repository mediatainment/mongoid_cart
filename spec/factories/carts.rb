FactoryGirl.define do

  factory :cart, class: MongoidCart::Cart do
    customer

    trait :with_items do
      association :cart_items, factory: :cart_item
    end
  end
end
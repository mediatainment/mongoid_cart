FactoryGirl.define do

  factory :user do
    sequence(:email) {|n| "Name#{n}" }
    password Random.rand(9999999)
  end

end
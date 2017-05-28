FactoryGirl.define do
  factory :dish do
    dish { Faker::Dessert.variety }
    price { Faker::Number::decimal(2) }
    restaurant nil
  end
end

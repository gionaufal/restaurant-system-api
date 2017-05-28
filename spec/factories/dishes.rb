FactoryGirl.define do
  factory :dish do
    dish { Faker::Food.ingredient }
    price { Faker::Number::decimal(2) }
    restaurant nil
  end
end

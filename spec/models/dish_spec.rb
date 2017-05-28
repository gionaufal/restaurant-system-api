require 'rails_helper'

RSpec.describe Dish, type: :model do
  it { should validate_presence_of(:dish) }
  it { should validate_presence_of(:price) }
end

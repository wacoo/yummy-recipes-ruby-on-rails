require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
  let(:recipe) do
    Recipe.new(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true, user: user)
  end
  let(:food) { Food.new(name: 'Apple', measurement_unit: 'KG', price: 6, quantity: 10, user: user) }

  subject do
    RecipeFood.new(recipe: recipe, food: food, quantity: 4)
  end

  before do
    user.save
    recipe.save
    food.save
    subject.save
  end

  it('quantity should be string') do
    subject.quantity = nil
    expect(subject).not_to be_valid
  end

  it('quantity should be greater than or equal to 0') do
    subject.quantity = -2
    expect(subject).not_to be_valid
  end
end

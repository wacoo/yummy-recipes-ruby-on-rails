require 'rails_helper'

def sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, options: {
      binary: '/usr/bin/google-chrome' # Replace with the actual Chrome binary location on your Chromebook
    }
  end
end

RSpec.describe 'RecipeFood', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'John', email: 'xyz@gmail.com', password: '123456', role: 'Admin')
  end

  before do
    @user2 = User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456')
    @recipe1 = Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food',
                             public: true, user: user1)
    @recipe2 = Recipe.create(name: 'PB and J', preparation_time: 15, cooking_time: 5,
                             description: 'Peanut butter and jam', public: false, user: user1)
    @food1 = Food.create(name: 'Apple', measurement_unit: 'KG', price: 6, quantity: 10, user: user1)
    @food2 = Food.create(name: 'Ginger', measurement_unit: 'PCs', price: 3, quantity: 5, user: user1)
  end

  context 'new' do
    scenario 'from submission should successfully' do
      visit new_recipe_recipe_food_path(@recipe1)
      sign_in(user1)
      fill_in 'Quantity', with: 5
      select 'Apple', from: 'Food'
      click_button 'Add new ingredient'
      expect(page).to have_content('Recipe food created successfully!')
    end
  end
end

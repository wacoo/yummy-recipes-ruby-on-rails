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

RSpec.describe 'Recipe', type: :system do
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
  end
  context 'index' do
    scenario 'should show recipe names' do
      visit recipes_path
      sign_in(user1)
      expect(page).to have_content('Stake')
      expect(page).to have_content('PB and J')
    end

    scenario 'should show recipe description' do
      visit recipes_path
      sign_in(user1)
      expect(page).to have_content('Yummy food')
      expect(page).to have_content('Peanut butter and jam')
    end

    scenario 'should navigate to details page' do
      visit recipes_path
      sign_in(user1)
      click_link 'Stake'
      expect(page).to have_current_path(recipe_path(@recipe1.id))
    end

    scenario 'should remove a recipe' do
      visit recipes_path
      sign_in(user1)
      click_button('REMOVE', match: :first)
      expect(page).to have_content('Recipe deleted successfully.')
    end
  end

  context 'new' do
    scenario 'from submission should successfully' do
      visit new_recipe_path
      sign_in(user1)
      fill_in 'Name', with: 'Kay wet'
      fill_in 'Preparation time', with: 2
      fill_in 'Cooking time', with: 3
      fill_in 'Description', with: 'Meat stew'
      check('Public')
      click_button 'CREATE RECIPE'
      expect(page).to have_content('Recipe created successfully.')
      expect(page).to have_content('Owner: John')
      expect(page).to have_content('Meat stew')
      expect(page).to have_content('Preparation time: 2 hours')
      expect(page).to have_content('Cooking time: 3 hours')
    end
  end
  context 'show' do
    scenario 'should show recipe name' do
      visit recipe_path(@recipe2)
      sign_in(user1)
      expect(page).to have_content('PB and J')
      expect(page).to have_content('Peanut butter and jam')
      expect(page).to have_content('Preparation time: 15 hours')
      expect(page).to have_content('Cooking time: 5 hours')
      expect(page).to have_content('GENERATE SHOPPING LIST')
      expect(page).to have_content('ADD INGREDIENTS')
    end
  end

    scenario 'should redirect to the general shopping list' do
      visit recipe_path(@recipe2)
      sign_in(user1)
      click_link 'GENERATE SHOPPING LIST'
      expect(page).to have_current_path('/general_shopping_list')
    end

    scenario 'should redirect to the add ingredients page' do
      visit recipe_path(@recipe2)
      sign_in(user1)
      click_link 'ADD INGREDIENTS'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe2))
    end

    context 'general shopping list' do
      scenario 'should have content' do
        visit '/general_shopping_list'
        sign_in(user1)
        expect(page).to have_content('General Shopping List')
        expect(page).to have_content('Food')
        expect(page).to have_content('Quantity')
        expect(page).to have_content('Price')
      end
    end
    
    context 'public recipes' do
      scenario 'should have content' do
        visit '/public_recipes'
        sign_in(user1)
        expect(page).to have_content('Public Recipes')
        expect(page).to have_content('Total food items')
        expect(page).to have_content('Total price')
        expect(page).to have_content('Stake')
        expect(page).to have_content('By John')
      end
    end
end

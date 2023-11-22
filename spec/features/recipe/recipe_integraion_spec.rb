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
    User.create(name: 'John', email: 'xyz@gmail.com', password: '123456')
  end

  before do
    @user2 = User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456')
    @recipe1 = Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true, user: user1)
    @recipe2 = Recipe.create(name: 'PB and J', preparation_time: 15, cooking_time: 5, description: 'Peanut butter and jam', public: false, user: user1)
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
  end

  context 'new' do
    scenario 'from submission should successfully' do
      visit new_recipe_path
      sign_in(user1)
      fill_in 'Name', with: 'Kay wet'
      fill_in 'Preparation time', with: 2
      fill_in 'Cooking time', with: 3
      fill_in 'Description', with: "Meat stew"
      check('Public')
      click_button 'CREATE RECIPE'
      expect(page).to have_content('Recipe created successfully.')
      expect(page).to have_content('Owner: John')
      expect(page).to have_content('Description: Meat stew')
      expect(page).to have_content('Prep. time: 2')
      expect(page).to have_content('Cooking time: 3')
    end
end
context 'show' do
  #TODO
end
  
  #   scenario 'should redirect to the right post' do
  #     visit user_posts_path(user1)
  #     click_link '2'
  #     click_link 'Post: Name of the fire'
  #     expect(page).to have_current_path(user_post_path(user1, @post2))
  #   end

end

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
      binary: '/usr/bin/google-chrome'
    }
  end
end
RSpec.describe 'Food', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'John', email: 'xyz@gmail.com', password: '123456', role: 'Admin')
  end

  before do
    @user2 = User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456')
    @food1 = Food.new(name: 'Apple', measurement_unit: 'KG', price: 6, quantity: 10, user: user1)
    @food2 = Food.new(name: 'Ginger', measurement_unit: 'PCs', price: 3, quantity: 5, user: user1)

    @food1.save
    @food2.save
  end

  context 'index' do
    scenario 'should show food names' do
      visit foods_path
      sign_in(user1)
      expect(page).to have_content('Action')
      expect(page).to have_content('Apple')
    end

    scenario 'should show measurement units' do
      visit foods_path
      sign_in(user1)
      expect(page).to have_content('KG')
      expect(page).to have_content('PCs')
    end

    scenario 'should show price and quantity' do
      visit foods_path
      sign_in(user1)
      expect(page).to have_content(6)
      expect(page).to have_content(3)
    end

    scenario 'should remove food from table' do
      visit foods_path
      sign_in(user1)
      click_button('DELETE', match: :first)
      expect(page).to have_content('Food removed successfully.')
    end

    scenario 'should navigate to add food page' do
      visit foods_path
      sign_in(user1)
      click_link 'ADD FOOD'
      expect(page).to have_current_path('/foods/new')
    end
  end

  context 'new' do
    scenario 'from submission should successfully' do
      visit new_food_path
      sign_in(user1)
      fill_in 'Name', with: 'Potato'
      fill_in 'Measurement unit', with: 'KG'
      fill_in 'Price', with: 3
      fill_in 'Quantity', with: 10
      click_button 'CREATE FOOD'
      expect(page).to have_current_path(foods_path)
      expect(page).to have_content('Food created successfully.')
    end
  end
end
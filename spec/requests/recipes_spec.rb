require 'rails_helper'

def sign_in(user)
  post user_session_path, params: { user: { email: user.email, password: user.password } }
end

RSpec.describe 'Recipe', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:recipe) do
      Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true,
                    user: user)
    end
    it 'should http status 200' do
      sign_in(user)
      get recipes_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      get recipes_path
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      sign_in(user)
      get recipes_path(user)
      expect(response.body).to include('ADD RECIPE')
    end
  end

  describe 'GET #show' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:recipe) do
      Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true,
                    user: user)
    end

    it 'returns a correct response' do
      sign_in(user)
      get recipe_path(recipe)
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      sign_in(user)
      get recipe_path(recipe)
      expect(response.body).to render_template('show')
    end

    it 'correct place holder text' do
      sign_in(user)
      get recipe_path(recipe)
      expect(response.body).to include('ADD INGREDIENTS')
    end
  end
  describe 'GET #general shopping list' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:recipe) do
      Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true,
                    user: user)
    end

    it 'returns a correct response' do
      sign_in(user)
      get '/general_shopping_list'
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      sign_in(user)
      get '/general_shopping_list'
      expect(response.body).to render_template('general_shopping_list')
    end

    it 'correct place holder text' do
      sign_in(user)
      get '/general_shopping_list'
      expect(response.body).to include('General Shopping List')
    end
  end

  describe 'GET #general shopping list' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:recipe) do
      Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true,
                    user: user)
    end

    it 'returns a correct response' do
      sign_in(user)
      get '/public_recipes'
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      sign_in(user)
      get '/public_recipes'
      expect(response.body).to render_template('public_recipes')
    end

    it 'correct place holder text' do
      sign_in(user)
      get '/public_recipes'
      expect(response.body).to include('Public Recipes')
    end
  end
end

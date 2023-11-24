require 'rails_helper'

def sign_in(user)
  post user_session_path, params: { user: { email: user.email, password: user.password } }
end

RSpec.describe 'Food', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456', role: 'Admin') }
    let!(:food) do
      Food.new(name: 'Apple', measurement_unit: 'KG', price: 6, quantity: 10, user: user)
    end
    it 'should http status 200' do
      sign_in(user)
      get foods_path
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      sign_in(user)
      get foods_path
      expect(response.body).to render_template('index')
    end

    it 'correct place holder text' do
      sign_in(user)
      get foods_path(user)
      expect(response.body).to include('ADD FOOD')
    end
  end
end

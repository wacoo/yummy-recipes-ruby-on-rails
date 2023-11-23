require 'rails_helper'

def sign_in(user)
  post user_session_path, params: { user: { email: user.email, password: user.password } }
end

RSpec.describe 'Recipe', type: :request do
  describe 'GET #index' do
    let!(:user) { User.create(name: 'Lily', email: 'abc@gmail.com', password: '123456') }
    let!(:recipe) do
      Recipe.create(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true,
                    user: user)
    end

    it 'should http status 200' do
      get recipes_path(user)
      sign_in(user)
      expect(response).to have_http_status(200)
    end

    it 'render template' do
      get recipes_path
      sign_in(user)
      expect(response.body).to render_template('index')
    end

    # it 'correct place holder text' do
    #   get user_posts_path(user)
    #   expect(response.body).to include('Here is a list of posts')
    # end
  end

  describe 'GET #show' do
    # let!(:userx) { User.create(name: 'Sarah', photo: 'photos.com/sarah', bio: 'this is my bio', posts_counter: 0) }
    # let!(:post3) do
    #   Post.create(author: userx, title: 'Art', text: 'Art is great!', comments_counter: 0, likes_counter: 0)
    # end

    # it 'returns a correct response' do
    #   get user_post_path(userx, post3)
    #   expect(response).to have_http_status(200)
    # end

    # it "renders the 'show' template" do
    #   get user_post_path(userx, post3)
    #   expect(response.body).to render_template('show')
    # end

    # it 'correct place holder text' do
    #   get user_post_path(userx, post3)
    #   expect(response.body).to include('Here is a post')
    # end
  end
end

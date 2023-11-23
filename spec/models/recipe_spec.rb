require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456') }
  subject do
    Recipe.new(name: 'Stake', preparation_time: 2, cooking_time: 6, description: 'Yummy food', public: true, user: user)
  end

  before do
    user.save
    subject.save
  end

  it('empty name should not be valid') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('empty preparation time not be valid') do
    subject.preparation_time = nil
    expect(subject).not_to be_valid
  end

  it('empty cooking time not be valid') do
    subject.cooking_time = nil
    expect(subject).not_to be_valid
  end

  it('name should be valid') do
    subject.name = 'Mac and cheese'
    expect(subject).to be_valid
  end

  it('preparation time be positive') do
    subject.preparation_time = 2
    expect(subject).to be_valid
  end

  it('cooking time not be positive') do
    subject.cooking_time = 5
    expect(subject).to be_valid
  end

  it('preparation time should not be negative') do
    subject.preparation_time = -1
    expect(subject).not_to be_valid
  end

  it('cooking time should not be negative') do
    subject.cooking_time = -2
    expect(subject).not_to be_valid
  end

  # it('comments_counter should be a number') do
  #   subject.comments_counter = nil
  #   expect(subject).not_to be_valid
  # end

  # it('comments_counter should be greater than or equal to 0') do
  #   subject.comments_counter = -1
  #   expect(subject).not_to be_valid
  # end

  # it('comments_counter should be equal to 0') do
  #   subject.comments_counter = 0
  #   expect(subject).to be_valid
  # end

  # it('comments_counter should be greater than 0') do
  #   subject.comments_counter = 3
  #   expect(subject).to be_valid
  # end

  # it('likes_counter should be a number') do
  #   subject.likes_counter = nil
  #   expect(subject).not_to be_valid
  # end

  # it('likes_counter should be greater than or equal to 0') do
  #   subject.likes_counter = -1
  #   expect(subject).not_to be_valid
  # end

  # it('likes_counter should be equal to 0') do
  #   subject.likes_counter = 0
  #   expect(subject).to be_valid
  # end

  # it('likes_counter should be greater than 0') do
  #   subject.likes_counter = 3
  #   expect(subject).to be_valid
  # end

  # it 'returns the five most recent comments for a post' do
  #   user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
  #                      posts_counter: 0)
  #   post = Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
  #                      likes_counter: 0)

  #   Comment.create(post: post, user: user, text: 'Hi Tom!')
  #   comment2 = Comment.create(post: post, user: user, text: 'Amazing!')
  #   comment3 = Comment.create(post: post, user: user, text: 'When is the next post?')
  #   comment4 = Comment.create(post: post, user: user, text: 'I have a question')
  #   comment5 = Comment.create(post: post, user: user, text: 'Hello!')
  #   comment6 = Comment.create(post: post, user: user, text: 'It\'s me')

  #   recent_comments = post.five_recent_comments.to_a

  #   expect(recent_comments).to match_array([comment6, comment5, comment4, comment3, comment2])
  # end

  # it('posts_counter should increment') do
  #   user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
  #                      posts_counter: 0)
  #   before_post = user.posts_counter
  #   Post.create(author: user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
  #               likes_counter: 0)
  #   after_post = user.posts_counter
  #   expect(after_post).to eql(before_post + 1)
  # end
end

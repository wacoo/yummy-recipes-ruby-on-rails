require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
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
end

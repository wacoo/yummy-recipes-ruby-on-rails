require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.new(name: 'Tom', email: 'example@gmail.com', password: '123456', role: 'Admin') }
  subject do
    Food.new(name: 'Apple', measurement_unit: 'KG', price: 6, quantity: 10, user: user)
  end

  before do
    user.save
    subject.save
  end

  it('empty name should not be valid') do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it('empty measurement unit should not be valid') do
    subject.measurement_unit = nil
    expect(subject).not_to be_valid
  end

  it('empty price should not be valid') do
    subject.price = nil
    expect(subject).not_to be_valid
  end

  it('empty quantity should not be valid') do
    subject.quantity = nil
    expect(subject).not_to be_valid
  end

  it('price should not be negative') do
    subject.price = -1
    expect(subject).not_to be_valid
  end
end

class Food < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_and_belongs_to_many :recipes
end

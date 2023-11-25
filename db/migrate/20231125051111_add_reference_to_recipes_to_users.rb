class AddReferenceToRecipesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :recipes, :users, column: :user_id
  end
end

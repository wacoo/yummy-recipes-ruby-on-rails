class AddReferenceToFoodsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :foods, :users, column: :user_id
  end
end

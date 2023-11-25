class CreateRecipeFood < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.float :quantity
      t.integer :recipe_id
      t.integer :food_id

      t.timestamps
    end
  end
end

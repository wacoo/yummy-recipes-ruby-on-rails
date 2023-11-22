class CreateJoinTableFoodRecipe < ActiveRecord::Migration[7.1]
  def change
    create_join_table :recipes, :foods do |t|
      t.index [:food_id, :recipe_id]
      t.index [:recipe_id, :food_id]
    end
  end
end

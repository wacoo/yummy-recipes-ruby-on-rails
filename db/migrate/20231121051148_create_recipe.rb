class CreateRecipe < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :preparation_time
      t.integer :cooking_time
      t.text :description
      t.boolean :public
      t.integer :user_id

      t.timestamps
    end
  end
end

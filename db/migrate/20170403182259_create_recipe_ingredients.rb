class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def up
    create_table :recipe_ingredients do |t|
        t.integer :recipe_id #foreign key to recipes
        t.integer :ingredient_id #foreing key to ingredients
    end
  end

  def down
    drop_table :recipe_ingredients
  end
end

class AddDirectionsToRecipes < ActiveRecord::Migration[5.0]
  def up
    add_column :recipes, :directions, :text
  end

  def down
    remove_column "recipes", "directions"
  end
end

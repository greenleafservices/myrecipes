class AddSynopsisToRecipe < ActiveRecord::Migration[5.0]
  def up
    add_column :recipes, :synopsis, :string
  end

  def down
    remove_column "recipes", "synopsis"
  end
end

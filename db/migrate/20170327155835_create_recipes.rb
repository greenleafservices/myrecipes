class CreateRecipes < ActiveRecord::Migration[5.0]
  def up
    create_table :recipes do |t|
      t.string "name"
      t.text "description"
      t.integer "chef_id"
      t.timestamps
    end
    add_index("recipes", "chef_id") #index to foreign table - table name_ID
  end

  def down
    drop_table :recipes
  end

end

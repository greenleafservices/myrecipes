class CreateIngredients < ActiveRecord::Migration[5.0]
  def up
    create_table :ingredients do |t|
      t.string :name
    end
  end

  def down
    drop_table :ingredients
  end
  
end

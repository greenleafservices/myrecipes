class CreateComments < ActiveRecord::Migration[5.0]
  def up
    create_table :comments do |t|
      t.text :description
      t.integer :chef_id #foreign key to chefs table
      t.integer :recipe_id #foreign key to recipes table
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end

end

class CreateChefs < ActiveRecord::Migration[5.0]
  def up
    create_table :chefs do |t|
      t.string "name"
      t.boolean "admin"
      t.string "email"
      t.string "password_digest"
      t.timestamps
    end
  end

  def down
    drop_table :chefs
  end

end

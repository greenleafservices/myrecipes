class CreateMessages < ActiveRecord::Migration[5.0]
  def up
    create_table :messages do |t|
      t.text :content
      t.integer :chef_id
      t.timestamps
    end
  end

  def down
    drop_table :messages
  end

end

class AddPwDigestToChefs < ActiveRecord::Migration[5.0]
  def up
    add_column :chefs, :password_digest, :string
  end

  def down
    remove_column "chefs", "password_digest"
  end
end

class MoveAdminColumn < ActiveRecord::Migration[5.0]
  def up
    change_column :chefs, :admin, :integer, after: :name
  end
end
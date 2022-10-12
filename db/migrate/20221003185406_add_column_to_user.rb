class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, :default => 2, foreign_key: true
    add_column :users, :active, :boolean, :default => false
  end
end

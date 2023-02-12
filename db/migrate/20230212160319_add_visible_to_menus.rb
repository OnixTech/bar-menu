class AddVisibleToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :visible, :boolean, :default => true
  end
end

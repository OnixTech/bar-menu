class AddPositionToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :position, :integer, :default => 0
  end
end

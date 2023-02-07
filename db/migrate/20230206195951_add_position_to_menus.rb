class AddPositionToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :position, :integer
  end
end

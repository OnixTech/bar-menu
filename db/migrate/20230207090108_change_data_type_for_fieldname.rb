class ChangeDataTypeForFieldname < ActiveRecord::Migration[7.0]
  def change
    change_column(:menus, :position, :float)
  end
  def change
    change_column(:items, :position, :float)
  end
end

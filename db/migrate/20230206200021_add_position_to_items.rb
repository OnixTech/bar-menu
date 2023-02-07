class AddPositionToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :position, :integer
  end
end

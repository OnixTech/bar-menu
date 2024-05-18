class ChangeItemIdInOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :order_items, :item_id, true
  end
end

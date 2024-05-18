class ChangeSubitemIdInOrderItems < ActiveRecord::Migration[7.0]
  def change
    change_column_null :order_items, :subitem_id, true
  end
end

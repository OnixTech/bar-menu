class AddNewColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :station, null: false, foreign_key: true
  end
end

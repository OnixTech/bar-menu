class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :table
      t.integer :numerference
      t.float :total
      t.timestamps
    end
  end
end

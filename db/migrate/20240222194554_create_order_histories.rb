class CreateOrderHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :order_histories do |t|
      t.references :order, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end

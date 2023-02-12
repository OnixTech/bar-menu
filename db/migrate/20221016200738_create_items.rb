class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name, null: true
      t.string :description, null: true
      t.string :inf_a, null: true
      t.string :inf_b, null: true
      t.integer :price, null: true, default: 0.00
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end

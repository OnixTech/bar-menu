class CreateSubitems < ActiveRecord::Migration[7.0]
  def change
    create_table :subitems do |t|
      t.string :name
      t.string :description
      t.float :price
      t.boolean :sumitem
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end

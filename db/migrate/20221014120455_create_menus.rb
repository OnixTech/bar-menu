class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :title, null: true
      t.string :subtitle, null: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :suburb
      t.string :street
      t.integer :number
      t.integer :post
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

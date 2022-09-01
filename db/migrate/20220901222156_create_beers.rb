class CreateBeers < ActiveRecord::Migration[7.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :family
      t.integer :price
      t.integer :abv

      t.timestamps
    end
  end
end

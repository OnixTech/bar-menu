class AddColumnsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :op_a, :string
    add_column :items, :op_b, :string
    add_column :items, :op_c, :string
    add_column :items, :op_d, :string
    add_column :items, :op_e, :string
    add_column :items, :price_a, :float, precision: 2, default: 0
    add_column :items, :price_b, :float, precision: 2, default: 0
    add_column :items, :price_c, :float, precision: 2, default: 0
    add_column :items, :price_d, :float, precision: 2, default: 0
    add_column :items, :price_e, :float, precision: 2, default: 0
    add_column :items, :price_io, :boolean, default: false
  end
end

class AddBasketToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :basket, :boolean, default: false
  end
end

class AddQrCodeToCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :qr_code, :string
  end
end

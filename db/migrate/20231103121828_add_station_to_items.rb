class AddStationToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :station, :string, :default => "main station"
  end
end

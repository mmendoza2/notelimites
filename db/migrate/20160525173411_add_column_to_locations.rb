class AddColumnToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :tm, :boolean


  end
end

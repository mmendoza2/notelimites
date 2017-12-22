class ChangeColumnLocationTable < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :float, limit: 8
    change_column :locations, :lng, :float, limit: 8
  end
end

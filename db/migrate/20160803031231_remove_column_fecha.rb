class RemoveColumnFecha < ActiveRecord::Migration
  def change
    remove_column :eventos, :fecha
  end
end

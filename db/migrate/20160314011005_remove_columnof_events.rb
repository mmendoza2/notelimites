class RemoveColumnofEvents < ActiveRecord::Migration
  def change
    remove_column :eventos, :agencia
    remove_column :eventos, :agencia_id
  end
end

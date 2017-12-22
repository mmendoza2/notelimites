class ChangeColumnActividades < ActiveRecord::Migration
  def change
    rename_column :actividades, :actividadpadre_id, :categoria_id
  end
end

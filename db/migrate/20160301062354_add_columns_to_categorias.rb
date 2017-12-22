class AddColumnsToCategorias < ActiveRecord::Migration
  def change
    add_column :categorias, :loc_id, :integer, limit:8
    add_column :locations, :uid, :integer, limit:8
    rename_column :categorias, :descripcion, :description
    remove_column :locations, :latitude
    remove_column :locations, :longitude
    remove_column :locations, :address
    remove_column :locations, :state
    remove_column :locations, :state_code
    remove_column :locations, :postal_code
    remove_column :locations, :country_code
    remove_column :locations, :distance
    remove_column :locations, :actividad_id
    remove_column :locations, :loc_id
    drop_table :actividades
    drop_table :relationactividades

  end
end

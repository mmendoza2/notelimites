class RenameEventoToEvent < ActiveRecord::Migration
  def change
    rename_table :eventos, :events
    rename_column :events, :urloficial, :official_url
    remove_column :events, :artista
    remove_column :events, :entradatipo
    remove_column :events, :precio
    rename_column :events, :imagen, :image
    remove_column :events, :lugar
    remove_column :events, :city
    remove_column :events, :actividad
    rename_column :events, :micrositio_id, :venue_id
    remove_column :events, :actividad_id
    remove_column :events, :location
    remove_column :events, :lat
    remove_column :events, :lng
    remove_column :events, :categoria_uid
    remove_column :events, :categoria
    rename_column :events, :categoria_id, :category_id
    rename_column :events, :fechainicio, :start_date
    rename_column :events, :fechafin, :end_date


  end
end

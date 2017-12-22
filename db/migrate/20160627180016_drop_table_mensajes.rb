class DropTableMensajes < ActiveRecord::Migration
  def change
    drop_table :mensajes
    drop_table :imagenes
    drop_table :authorizations
  end
end

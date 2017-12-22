class AddAgenciasToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :agencia, :string
  end
end

class AddColumnToEventos < ActiveRecord::Migration
  def change
    add_column :eventos, :agencia_id, :integer, limit:8
    add_column :eventos, :categoria_uid, :integer, limit:8
    add_column :eventos, :categoria_id, :integer, limit:8
    add_column :eventos, :categoria, :string
  end
end

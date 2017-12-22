class AddColumnToCategorias < ActiveRecord::Migration
  def change
    add_column :agencias, :categoria_id, :integer, limit:8
    add_column :categorias, :uid, :integer, limit:8
    drop_table :actimicros
  end
end

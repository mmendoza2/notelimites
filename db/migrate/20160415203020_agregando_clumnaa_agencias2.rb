class AgregandoClumnaaAgencias2 < ActiveRecord::Migration
  def change
    add_column :agencias, :categoriafb, :string
  end
end

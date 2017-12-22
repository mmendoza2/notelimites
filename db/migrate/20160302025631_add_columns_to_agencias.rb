class AddColumnsToAgencias < ActiveRecord::Migration
  def change

    add_column :agencias, :loc_id, :integer, limit:8
    add_column :agencias, :categoria, :integer, limit:8

  end
end

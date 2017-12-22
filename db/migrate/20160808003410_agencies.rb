class Agencies < ActiveRecord::Migration
  def change
    rename_table :agencias, :agencies
    rename_column :agencies, :categoria_id, :category_id
    remove_column :agencies, :loc_id
    remove_column :agencies, :categoria
    rename_column :agencies, :namefb, :slug
    rename_column :agencies, :categoriafb, :facebookCategory

  end
end

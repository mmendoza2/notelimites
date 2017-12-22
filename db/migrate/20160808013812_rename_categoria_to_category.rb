class RenameCategoriaToCategory < ActiveRecord::Migration
  def change
    rename_table :categorias, :categories
    rename_column :categories, :imagen, :image
    remove_column :categories, :icono
    remove_column :categories, :photo_content_type
    remove_column :categories, :photo_file_size
    remove_column :categories, :photo_updated_at
    remove_column :categories, :uid
    remove_column :categories, :loc_id
    remove_column :categories, :description


  end
end

class ChangeColumnFromMcirositio < ActiveRecord::Migration
  def change
    remove_column :micrositios, :reference
    remove_column :micrositios, :referencefb
    remove_column :micrositios, :actividad_id
    remove_column :micrositios, :favorito
    remove_column :micrositios, :urls
    remove_column :micrositios, :publish_up
    remove_column :micrositios, :mapa
    remove_column :micrositios, :comollegar
    remove_column :micrositios, :votos
    remove_column :micrositios, :fb_author
    remove_column :micrositios, :tagcategorias
    remove_column :micrositios, :status
    remove_column :micrositios, :photo_file_name
    remove_column :micrositios, :photo_updated_at
    remove_column :micrositios, :photo_file_size
    remove_column :micrositios, :photo_content_type
    remove_column :micrositios, :created_by
    remove_column :micrositios, :ordering
    remove_column :micrositios, :metakey
    remove_column :micrositios, :hits
    add_column    :micrositios, :urloficial, :text

  end
end

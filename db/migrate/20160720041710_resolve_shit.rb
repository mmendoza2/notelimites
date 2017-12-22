class ResolveShit < ActiveRecord::Migration
  def change
    create_table :delayed_jobs
    drop_table :delayed_jobs
    drop_table :relationestados
    remove_column :eventos, :photo_file_name
    remove_column :eventos, :photo_content_type
    remove_column :eventos, :photo_file_size
    remove_column :eventos, :photo_updated_at
    remove_column :eventos, :mes
    remove_column :eventos, :dia
    remove_column :eventos, :referencefb
    remove_column :eventos, :reference
    remove_column :eventos, :estado_id
    remove_column :eventos, :fotografia
  end
end

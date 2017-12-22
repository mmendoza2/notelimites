class ChangeColumnsImage < ActiveRecord::Migration
  def change

    remove_column :images, :image
    remove_column :images, :image_file_name
    remove_column :images, :image_file_size
    remove_column :images, :image_content_type
    remove_column :images, :image_updated_at

    add_column :images, :name, :string, limit: 255
    add_column :images, :photo_file_size, :integer
    add_column :images, :photo_file_name, :string, limit: 255
    add_column :images, :photo_content_type, :string
    add_column :images, :photo_updated_at, :datetime
  end
end

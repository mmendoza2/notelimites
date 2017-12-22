class ChangeColumnOnImage < ActiveRecord::Migration
  def change
    remove_column :images, :image_file_size
    remove_column :images, :image_updated_at
    add_column :images, :uder_id, :integer
    add_column :images, :venue_id, :integer
    add_column :images, :event_id, :integer
    add_column :images, :image_file_size, :integer
    add_column :images, :image_updated_at, :datetime
  end
end

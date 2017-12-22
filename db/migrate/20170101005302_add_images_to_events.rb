class AddImagesToEvents < ActiveRecord::Migration
  def change
    remove_column :images, :user_id
    remove_column :venues, :image_id
    remove_column :images, :name

  end
end

class ChangeColumnsFromVenue < ActiveRecord::Migration
  def change

    remove_column :images, :uder_id

    add_column :images, :user_id, :integer
    add_column :venues, :image_id, :integer

  end
end

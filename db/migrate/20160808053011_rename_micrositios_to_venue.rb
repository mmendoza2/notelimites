class RenameMicrositiosToVenue < ActiveRecord::Migration
  def change
    rename_table :micrositios, :venues
    rename_column :venues, :imagen, :image
    rename_column :venues, :lugar, :place
    remove_column :venues, :location_id
    remove_column :venues, :user_id
    remove_column :venues, :created
    rename_column :venues, :urloficial, :official_url

  end
end

class Agencies2 < ActiveRecord::Migration
  def change
    rename_column :agencies, :facebookCategory, :facebook_category
  end
end

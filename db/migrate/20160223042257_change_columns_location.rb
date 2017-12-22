class ChangeColumnsLocation < ActiveRecord::Migration
  def change
    change_column :locations, :lat, :text
    change_column :locations, :lng, :text
  end
end

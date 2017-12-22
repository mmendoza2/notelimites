class ChangeColumAfgencie < ActiveRecord::Migration
  def change
    change_column :relationcategories, :follower_id, :integer, limit: 8
  end
end

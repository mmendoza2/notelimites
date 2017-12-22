class ChangeLimitRelations < ActiveRecord::Migration
  def change
    change_column :relationcategories, :follower_id, :integer, limit: 8
    change_column :relationcategories, :followed_id, :integer, limit: 8
    change_column :relationevents, :follower_id, :integer, limit: 8
    change_column :relationevents, :followed_id, :integer, limit: 8
    change_column :relationships, :follower_id, :integer, limit: 8
    change_column :relationships, :followed_id, :integer, limit: 8
    change_column :relationvenues, :follower_id, :integer, limit: 8
    change_column :relationvenues, :followed_id, :integer, limit: 8
  end
end

class RemoveUnique < ActiveRecord::Migration
  def change
    remove_index :users, :uid
  end
end

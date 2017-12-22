class BorrandoTablas < ActiveRecord::Migration
  def change
    drop_table :search_suggestionns
  end
end

class ChangeTMtoBoolean < ActiveRecord::Migration
  def change
    change_column :events, :tm, :string
  end
end

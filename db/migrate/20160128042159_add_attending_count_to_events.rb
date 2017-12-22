class AddAttendingCountToEvents < ActiveRecord::Migration
  def change
    add_column :eventos, :attending_count, :integer, limit:8
  end
end

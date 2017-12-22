class AddColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :supplier_id, :string
  end
end

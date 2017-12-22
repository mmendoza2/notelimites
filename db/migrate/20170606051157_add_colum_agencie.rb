class AddColumAgencie < ActiveRecord::Migration
  def change
    add_column :events, :agencie_id, :string
  end
end

class AddColumnToAgencias < ActiveRecord::Migration
  def change
    add_column :agencias, :categoria, :string
  end
end

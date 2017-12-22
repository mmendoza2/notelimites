class AddFbuidToEstados < ActiveRecord::Migration
  def change
    add_column :estados, :fbuid, :integer, limit:8
    add_column :estados, :name, :string
  end
end

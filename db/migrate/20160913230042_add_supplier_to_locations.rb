class AddSupplierToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :supplier_id, :string
  end
end

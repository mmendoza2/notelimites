class VenuesWithSupplier < ActiveRecord::Migration
  def change
    add_column :venues, :supplier_id, :string
  end
end

class AddCityToAgencias < ActiveRecord::Migration
  def change
    add_column :agencias, :city, :string
  end
end

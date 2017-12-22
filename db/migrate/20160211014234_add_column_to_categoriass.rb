class AddColumnToCategoriass < ActiveRecord::Migration
  def change
    remove_column :agencias, :categoria
  end
end

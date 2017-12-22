class RenameAllRelations < ActiveRecord::Migration
  def change
    rename_table :relationeventos, :relationevents
    rename_table :relationcategorias, :relationcategories
    rename_table :relationmicrositios, :relationvenues


  end
end

class ChangeCategoriFromAgencias < ActiveRecord::Migration
  def change
    change_column :agencias, :categoria, :string
  end
end

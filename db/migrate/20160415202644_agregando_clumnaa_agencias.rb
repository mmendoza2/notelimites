class AgregandoClumnaaAgencias < ActiveRecord::Migration
  def change
    add_column :agencias, :namefb, :string
  end
end

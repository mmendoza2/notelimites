class QuitEstados < ActiveRecord::Migration
  def change
    drop_table :estados
  end
end

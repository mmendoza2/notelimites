class BorrandoTablas2 < ActiveRecord::Migration
  def change
    drop_table :search_suggestions
    drop_table :actividadespadre
    drop_table :categoria
    drop_table :delayed_jobs
    drop_table :locs
    drop_table :relationactividadespadre
    drop_table :microposts
  end
end

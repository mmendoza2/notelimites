class AddtmToEvents < ActiveRecord::Migration
  def change
    add_column :eventos, :tm, :boolean
    add_column :micrositios, :tm, :boolean
  end
end

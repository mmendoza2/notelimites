class ChangeDateColumns < ActiveRecord::Migration
  def change
    remove_column :eventos, :fechainicio
    remove_column :eventos, :fechafin
    add_column :eventos, :fechainicio, :datetime
    add_column :eventos, :fechafin, :datetime
  end
end

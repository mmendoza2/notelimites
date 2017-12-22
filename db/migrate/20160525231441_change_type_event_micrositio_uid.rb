class ChangeTypeEventMicrositioUid < ActiveRecord::Migration
  def change
    change_column :eventos, :micrositio_id, :string

  end
end

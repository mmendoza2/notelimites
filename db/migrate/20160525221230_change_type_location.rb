class ChangeTypeLocation < ActiveRecord::Migration
  def change
    change_column :eventos, :uid, :string
  end
end

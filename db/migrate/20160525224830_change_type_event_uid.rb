class ChangeTypeEventUid < ActiveRecord::Migration
  def change
    change_column :micrositios, :uid, :string
  end
end

class CreateAgencia < ActiveRecord::Migration
  def change
    create_table :agencias do |t|
      t.string :name
      t.integer :uid, limit: 8
    end
  end
end

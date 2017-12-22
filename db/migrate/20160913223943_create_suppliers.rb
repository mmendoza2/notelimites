class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string   "slug",            limit: 255
      t.string   "name",            limit: 255
      t.string   "image",           limit: 255
      t.string   "photo_file_name", limit: 255
      t.timestamps null: false
    end
  end
end

class CreateTableForImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
        t.string   "image_file_name", limit: 255
        t.string   "image_file_size", limit: 255
        t.string   "image_content_type", limit: 255
        t.string   "image_updated_at", limit: 255
        t.timestamps null: false

    end

  end
end

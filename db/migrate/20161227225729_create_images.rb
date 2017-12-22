class CreateImages < ActiveRecord::Migration
  def change
    add_column :images, :image, :string
  end
end

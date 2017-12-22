class AddUpdatedToagencies < ActiveRecord::Migration
  def change
    add_column :venues, :created_at, :datetime
    add_column :venues, :updated_at, :datetime
    add_column :categories, :created_at, :datetime
    add_column :categories, :updated_at, :datetime
    add_column :agencies, :created_at, :datetime
    add_column :agencies, :updated_at, :datetime



  end
end

class AddLocaletoUsers < ActiveRecord::Migration
  def change
    add_column :users, :locale, :string
  end
end

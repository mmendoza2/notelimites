class ChangeSendEmailType < ActiveRecord::Migration
  def change
    remove_column :users, :send_email
    add_column :users, :send_email, :boolean
  end
end

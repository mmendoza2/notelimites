class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_digest
    remove_column :users, :usertype
    remove_column :users, :block
    rename_column :users, :avatar, :image
    rename_column :users, :sendEmail, :send_email
    remove_column :users, :registerDate
    remove_column :users, :lastvisitDate
    remove_column :users, :activation
    remove_column :users, :params
    remove_column :users, :fb_author
    remove_column :users, :ntlparam
    remove_column :users, :photo_file_name
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_size
    remove_column :users, :photo_updated_at
    remove_column :users, :editor_estado

  end
end

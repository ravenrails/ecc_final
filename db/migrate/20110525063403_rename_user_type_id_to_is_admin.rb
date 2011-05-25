class RenameUserTypeIdToIsAdmin < ActiveRecord::Migration
  def self.up
    remove_column :users, :user_type_id
    add_column :users, :is_admin, :boolean  
  end

  def self.down
    remove_column :users, :is_admin
    add_column :users, :user_type_id, :integer  
  end
end

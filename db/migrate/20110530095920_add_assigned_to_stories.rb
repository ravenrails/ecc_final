class AddAssignedToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :assigned_to, :integer
  end

  def self.down
    remove_column :stories, :assigned_to
  end
end

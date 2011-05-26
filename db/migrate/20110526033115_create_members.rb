class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :project_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end

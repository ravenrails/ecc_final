class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :display, :default => 1
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end


class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :release_id
      t.string :name
      t.text :description
      t.integer :priority
      t.string :state, :default => 'New'
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end


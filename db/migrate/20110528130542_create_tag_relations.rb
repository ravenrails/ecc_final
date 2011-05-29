class CreateTagRelations < ActiveRecord::Migration
  def self.up
    create_table :tag_relations do |t|
      t.integer :story_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tag_relations
  end
end

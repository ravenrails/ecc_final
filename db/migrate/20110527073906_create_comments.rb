class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer   :story_id
      t.text      :content
      t.datetime  :comment_date
      t.integer   :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end


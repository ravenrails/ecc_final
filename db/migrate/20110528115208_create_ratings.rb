class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :story_id
      t.integer :rate

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end

class TagRelation < ActiveRecord::Base
  belongs_to :tag
  belongs_to :story
  
  class << self
    
    def relate(tags, story_id)
      TagRelation.where(:story_id => story_id).destroy_all

      tags.each do |tag|
        if TagRelation.where(:tag_id => tag.id, :story_id => story_id).empty?
          TagRelation.create :tag_id => tag.id, :story_id => story_id
        end
      end
    end
    
  end
end

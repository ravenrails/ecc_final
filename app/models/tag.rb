class Tag < ActiveRecord::Base
  has_many :tag_relations
  has_many :stories, :through => :tag_relations
  belongs_to :project
  belongs_to :creator, :class_name => "User"


  def frequency
    self.stories.count
  end

  def self.to_histogram
    Tag.all.inject({}){|set, t| set[t.name] = t.frequency; set }
  end

  class << self
    
    def save_tag(tags, project_id)
      compilation = []
      
      tags.uniq.each do |tag|        
        tag.strip!
        existing_tag = Tag.where(:name => tag, :project_id => project_id)
        
        if existing_tag.empty?
          existing_tag = Tag.create(:name => tag, :project_id => project_id)          
        else
          existing_tag = existing_tag[0]
        end
        
        compilation << existing_tag
      end
      
      compilation
    end
    
  end
end


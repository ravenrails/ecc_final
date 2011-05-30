class Story < ActiveRecord::Base
  belongs_to  :release
  has_many    :tag_relations
  has_many    :tags, :through => :tag_relations
  has_many    :comments
  has_many    :ratings
  belongs_to  :creator, :class_name => "User"
  has_one :user
  validates_length_of :name, :maximum => 140

  def tags_s
    str = ''

    self.tags.each do |tag|
      str << (str.empty? ? '': ', ') << tag.name
    end

    str
  end
end


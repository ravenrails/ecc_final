class Story < ActiveRecord::Base
  belongs_to  :release
  has_many    :tag_relations
  has_many    :tags, :through => :tag_relations
  has_many    :comments
  has_many    :ratings
  belongs_to  :creator, :class_name => "User"

  has_one :user

  validates_length_of :name, :maximum => 140
  #validate priority here

  def tags_s
    str = ''

    self.tags.each do |tag|
      str << (str.empty? ? '': ', ') << tag.name
    end

    str
  end

  def assigned_with
    User.find(self.assigned_to)
  end

  class << self

    def save_status(story, status)
      state = case status
        when 'Reject' then 'New'
        when 'Accept' then 'Close'
        else status
      end
      story.update_attribute :state, state
    end

  end
end


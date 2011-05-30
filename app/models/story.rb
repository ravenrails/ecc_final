class Story < ActiveRecord::Base
  belongs_to  :release
  has_many    :tag_relations
  has_many    :tags, :through => :tag_relations
  has_many    :comments
  has_many    :ratings
  belongs_to  :creator, :class_name => "User"
<<<<<<< HEAD

  has_one :user
=======
  has_one     :user

  validates_length_of :name, :maximum => 140
  #validate priority here
>>>>>>> 5c6c1de2e68811cc90b800d5fe73c401ad1b066e

  def tags_s
    str = ''

    self.tags.each do |tag|
      str << (str.empty? ? '': ', ') << tag.name
    end

    str
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


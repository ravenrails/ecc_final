class Release < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  belongs_to :creator, :class_name => "User"
  has_many :tags, :through => :stories
end


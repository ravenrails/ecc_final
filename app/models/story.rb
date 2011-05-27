class Story < ActiveRecord::Base
  belongs_to :release
  has_many :tags
  belongs_to :creator, :class_name => "User"
end


class Comment < ActiveRecord::Base
  belongs_to :story
  belongs_to :creator, :class_name => "User"
end


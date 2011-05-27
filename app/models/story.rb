class Story < ActiveRecord::Base
  belongs_to  :release
  has_many    :tags
  has_many    :comments
  belongs_to  :creator, :class_name => "User"
end


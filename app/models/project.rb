class Project < ActiveRecord::Base
  has_many :releases
  belongs_to :creator, :class_name => "User"

end


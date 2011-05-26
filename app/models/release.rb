class Release < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  belongs_to :creator, class => "User"

end


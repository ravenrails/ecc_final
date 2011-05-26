class Project < ActiveRecord::Base
  has_many :releases
  belongs_to :creator, class => "User"
  has_many :tags, through :stories
end


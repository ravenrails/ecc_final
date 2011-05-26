class Project < ActiveRecord::Base
  has_many :project_members
  has_many :users, :through => :project_members

 # has_many :releases
  #belongs_to :creator, :class_name => "User"

  def members
    self.users
  end
end


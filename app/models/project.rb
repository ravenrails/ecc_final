class Project < ActiveRecord::Base
  has_many :project_members
  has_many :tags
  has_many :users, :through => :project_members

  has_many :releases
  #belongs_to :creator, :class_name => "User"

  # if disabled only admin can see project
  # must have name(140), description
  # Only Project Owner/Manager can create
  # Assigned to a member  

  # Story with no release is in Backlogs list - create controller for this
  

  def members
    self.users
  end
end


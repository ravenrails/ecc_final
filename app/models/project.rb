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
  
  
  def all_members 
    members = []
    
    project_members.owner.each { |u| members[u.user_id] = u }    
    project_members.manager.each do |u|
      if members[u.user_id].nil?
        members[u.user_id] = u
      else
        members[u.user_id].role_id += ', ' + u.role_id
      end
    end
    
    project_members.member.each do |u|
      if members[u.user_id].nil?
        members[u.user_id] = u
      else
        members[u.user_id].role_id.to_s += ', ' + u.role_id
      end
    end
    
    members.compact
  end

  def members
    self.users
  end
end


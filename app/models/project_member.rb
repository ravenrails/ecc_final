class ProjectMember < ActiveRecord::Base
  ###########################################################
  ## Constants
  P_OWNER = Role.where(:name => 'Project Owner').first
  P_MNGR  = Role.where(:name => 'Project Manager').first
  MEMBER  = Role.where(:name => 'Member').first
  ###########################################################
  ## Associations
  belongs_to :project
  belongs_to :user
  belongs_to :role
  ###########################################################
  ## Scopes
  scope :owner   , lambda { where( :role_id => P_OWNER.id) }
  scope :manager , lambda { where( :role_id => P_MNGR.id) }
  scope :member  , lambda { where( :role_id => MEMBER.id) }
  ###########################################################

  def role_name
    role_name = ''

    role_id.split(',').each do |id|
      role_name << (role_name.empty? ? '' : '|') << Role.find(id).name
    end

    role_name.strip.gsub '|', ', '
  end
end

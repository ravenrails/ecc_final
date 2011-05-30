class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #####################################################################
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation,
                  :remember_me, :firstname, :lastname, :bday

  #####################################################################
  # Associations:
  has_many :project_members
  has_many :projects, :through => :project_members
  has_many :roles, :through => :project_members
  #has_many :roles, :through => :project_members
  #has_many :releases, :foreign_key => :creator_id
  #has_many :stories,  :foreign_key => :creator_id

  belongs_to :story, :foreign_key => :assigned_to

  def fullname
    return 'blank username' if self.username.nil?
    return self.username if self.lastname.nil?
    self.firstname + ' ' + self.lastname
  end

  def all_projects
    c = []
    self.projects.each do |p|
      c[p.id] = p if c[p.id].nil?
    end
    c.compact
  end

  def role_names
    self.roles.reduce('') { |c, x| c << ( c.empty? ? '' : ', ') << x.name }
  end
end


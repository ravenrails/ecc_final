class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me,
    :firstname, :lastname, :bday

  # associations:
  has_many :project_members
  has_many :projects, :through => :project_members
  has_many :roles, :through => :project_members
  #has_many :roles, :through => :project_members
  #has_many :releases, :foreign_key => :creator_id
  #has_many :stories,  :foreign_key => :creator_id

  belongs_to :story, :foreign_key => :assigned_to

  def fullname
    self.firstname + ' ' + self.lastname
  end

  def is_admin?
    self.is_admin
  end

  def role_names
    self.roles.reduce('') { |c, x| c << ( c.empty? ? '' : ', ') << x.name }
  end
end


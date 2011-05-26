class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :firstname, :lastname, :bday, :is_admin

  # associations:
  has_many :projects, :foreign_key => :creator_id
  has_many :releases, :foreign_key => :creator_id
  has_many :stories,  :foreign_key => :creator_id

  def fullname
    self.firstname + ' ' + self.lastname
  end

  def is_admin?
    self.is_admin
  end
end


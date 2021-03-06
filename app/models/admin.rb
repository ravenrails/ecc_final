class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation,
    :remember_me, :firstname, :lastname, :bday


  def fullname
    if self.firstname.nil?
      return 'n/a' if self.username.nil?
      return self.username
    end
    self.firstname + ' ' + self.lastname
  end
end


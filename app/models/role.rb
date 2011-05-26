class Role < ActiveRecord::Base
  has_many :project_members
  belongs_to :user
end

class ProjectMember < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :role

  def role_names
    ids = self.role_id.split '-'
    name = ''

    ids.each do |id|
      name << (name.empty? ? '' : ', ') << Role.find(id).name
    end
  end
end

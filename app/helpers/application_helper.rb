module ApplicationHelper

  PROJECT_OWNER = Role.where(:name => 'Project Owner').first
  PROJECT_MANAGER = Role.where(:name => 'Project Manager').first

  def heatmap(histogram={})
    html = %{<div class="heatmap">}
    _max = histogram.map{|k,v| histogram[k]}.max * 2
    histogram.keys.sort{|a,b| histogram[a] <=> histogram[b]}.reverse.each do |k|
      next if histogram[k] < 1
      _size = (((histogram[k] / histogram.map{|key,val| histogram[key]}.sum.to_f) * 100) + 5).to_i
      _heat = sprintf("%02x" % (255 - (_size * 25)))
      html << %{
        <div class="heatmap_element" style="color: ##{_heat}#{_heat}#{_heat}; font-size: #{_size}px; height: #{_max}px;">#{k}</div>
      }
    end
    html << %{<br style="clear: both;" /></div>}
  end

  def render_top_menu
    return render :partial => 'admin/top_menu' if admin_signed_in?
    return render :partial => 'users/top_menu' if user_signed_in?      
  end

  def delete(url, title, callback = '')
    %Q[javascript:$.confirmDelete("#{url}", "#{title}", "#{callback}")]
  end
  
  def authorize_for_release_crud?(project)
    ProjectMember.where('project_id = ? AND user_id = ? AND (role_id = ? OR role_id = ?)', 
       project.id, current_user.id, PROJECT_OWNER.id, PROJECT_MANAGER.id).count > 0
  end
  
  def authorize_for_story_crud?(release)
    ProjectMember.where('project_id = ? AND user_id = ? AND (role_id = ? OR role_id = ?)', 
       release.project.id, current_user.id, PROJECT_OWNER.id, PROJECT_MANAGER.id).count > 0
  end
end


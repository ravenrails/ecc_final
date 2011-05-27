module ApplicationHelper

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
    html = %{<div id="top-menu">
      <div id="account">
        <ul>
          <li><a href="http://demo.redmine.org/my/account" class="my-account">My account</a></li>
          <li><a href="#{destroy_user_session_path}" class="logout">Sign out</a></li>
        </ul>
      </div>
      <div id="loggedas">Logged in as <a href="http://demo.redmine.org/users/9121">animpo</a></div>
      <ul>
        <li><a href="http://demo.redmine.org/" class="home">Home</a></li>
        <li><a href="http://demo.redmine.org/my/page" class="my-page">My page</a></li>
        <li><a href="http://demo.redmine.org/projects" class="projects">Projects</a></li>
      </ul>
    </div>}

    html.html_safe
  end

  def delete(url, title)
    %Q[javascript:$.confirmDelete("#{url}", "#{title}")]
  end
end


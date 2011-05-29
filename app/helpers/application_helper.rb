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
    return render :partial => 'admin/top_menu' if admin_signed_in?
    return render :partial => 'layout/top_menu' if user_signed_in?      
  end

  def delete(url, title, callback = '')
    %Q[javascript:$.confirmDelete("#{url}", "#{title}", "#{callback}")]
  end
end


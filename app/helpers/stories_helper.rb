module StoriesHelper

  def render_status_buttons(role = 1)
    options, html = [], ''

    options += %w[ Reject Accept ] if true 
    options += %w[ Start Hold Finish ] if true

    options.each do |opt|
      html << link_to( opt, '#', :class => 'button',
                       :onclick => 'updateStatus('+ opt +')')
    end

    html.html_safe
  end

end

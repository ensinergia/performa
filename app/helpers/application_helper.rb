module ApplicationHelper
  def with_current_subdomain
    {:subdomain => (@user|| current_user).subdomain}
  end
  
  def task_number_for(user)
    task_count = current_user.tasks.count
    text = task_count == 1 ? t('views.header.pending_tasks.one') : t('views.header.pending_tasks.other')
    "<b>#{link_to task_count, '' }</b> #{text}".html_safe
  end
  
  def all_selector_for_area_for(user)
    "#{label_tag t('views.creed.most_views.controls.all_selector')} #{user.area.name}".html_safe
  end
  
  def record_info_for(record)
    "#{t('views.comments.message.connector')} #{record.user.name} / #{l(record.updated_at, :format => :short)}"
  end
  
  def render_links_for_comments_number(comment_number)
    render :partial => "comments/links", :locals => {:comments => comment_number}
  end
  
  def line_break(string)
    string.gsub("\n", '<br/>').html_safe
  end
end

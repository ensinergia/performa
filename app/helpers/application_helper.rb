module ApplicationHelper
  def with_current_subdomain
    {:subdomain => (@user|| current_user).subdomain}
  end
  
  def task_number_for(user)
    task_count = current_user.tasks.count
    text = task_count == 1 ? t('views.header.pending_tasks.one') : t('views.header.pending_tasks.other')
    "<b>#{link_to task_count, '' }</b> #{text}".html_safe
  end
end

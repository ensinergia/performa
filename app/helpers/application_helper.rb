module ApplicationHelper
  def with_current_subdomain
    {:subdomain => (@user|| current_user).domain}
  end
end

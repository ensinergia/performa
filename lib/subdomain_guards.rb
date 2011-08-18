module SubdomainGuards
  def valid_subdomain?
    !current_user.nil?  && request.subdomain == current_user.subdomain
  end
  
  def verify_subdomain
    render(:nothing => true) unless valid_subdomain?
  end
end
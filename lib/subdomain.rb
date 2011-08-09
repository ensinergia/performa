class Subdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != "www"
  end
end

class NoSubdomain
  def self.matches?(request)
    !request.subdomain.present?
  end
end
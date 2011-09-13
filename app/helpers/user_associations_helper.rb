module UserAssociationsHelper
  def current_company
    current_user.company unless current_user.nil?
  end
end
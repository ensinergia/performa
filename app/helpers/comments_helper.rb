module CommentsHelper
  def generate_links_for(commentable_type, comment_number)
    escape_javascript(render :partial => "creed/#{commentable_type.pluralize.downcase}/links", :locals => {:comments => comment_number})
  end
end


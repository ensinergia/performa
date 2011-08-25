module HelperMethods
  # Put here any helper method you need to be available in all your acceptance tests
  def should_have_comment(comment, user, deletable=true, other_checks=nil)
    within("#comment-#{comment.id}") do
      page.should have_content user.name
      page.should have_content I18n.l(comment.created_at, :format => :short)
      page.should have_content comment.content
      if deletable
        find(:css, '.delete-comment')
        find_button I18n.t('views.creed.comments.controls.delete')
      end
    end
    other_checks.call() unless other_checks.nil?
  end
  
  def with_delete_controls
    true
  end
  
  def without_delete_controls
    false
  end
  
  def with_attachments(attachs)
    lambda do
      page.should have_content I18n.t('views.creed.comments.attachments')
      attachs.each do |a|
        find_link a
      end
    end
  end
end

RSpec.configuration.include(HelperMethods)

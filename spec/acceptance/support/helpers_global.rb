module HelperMethods
  # Put here any helper method you need to be available in all your acceptance tests
  def should_have_comment(comment, user, deletable=true, other_checks=nil)
    within("#comment-#{comment.id}") do
      page.should have_content user.name
      page.should have_content I18n.l(comment.created_at, :format => :short)
      page.should have_content comment.content
      if deletable
        page.should have_xpath("//input[contains(@class, 'delete-comment')]")
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
      page.should have_content I18n.t('views.comments.attachments')
      attachs.each do |a|
        find_link a
      end
    end
  end
  
  def notifications_area_with(owner, users)
    page.should have_content I18n.t('views.creed.most_views.controls.all_selector') + owner.area.name
    find_field 'select_everyone'
    
    users[:notified].each do |notified_user|
      # should show this user as him belongs to the same area
      page.should have_content notified_user.name      
      page.should have_selector(:xpath, "//input[@type='checkbox' and @name='users[#{notified_user.id}]']")
    end

    users[:unnotified].each do |unnotified_user|
      # should not show this user as it does not belong to the same area
      page.should_not have_content unnotified_user.name
      page.should have_no_selector(:xpath, "//input[@type='checkbox' and @name='users[#{unnotified_user.id}]']")
    end
  end
  
  def should_contain_class(dom_element, klass)
    page.should have_xpath("//#{dom_element}[contains(concat(' ',normalize-space(@class),' '),' #{klass} ')]");
  end
  
  def should_contain_record_info_for(comment)
    page.should have_content("#{I18n.t('views.comments.message.connector')} #{comment.user.name} / #{I18n.l(comment.updated_at, :format => :short)}")
  end
  
  def ignoring_new_lines(string)
    string.gsub("\n", '').html_safe
  end
end

RSpec.configuration.include(HelperMethods)

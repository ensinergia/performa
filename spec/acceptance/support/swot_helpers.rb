module SwotHelperMethods

  def should_have_analysis_record_for(analysis)
    within("#analysis-#{analysis.id}") do
      page.should have_content analysis.content
      #page.should have_content analysis.comments.count
      #should_contain_class("a", "comment")
      page.should have_xpath("//span[contains(@class, 'inline-analysis-value')]")
      page.should have_xpath("//input[contains(@class, 'delete')]")
    end
  end

  def should_have_comment_page_elements_for(analysis)
    click_link I18n.t('views.menu.swot')
  
    find(:xpath, "//a[contains(@class, 'comment')]").click
  
    current_url.should == @sub_host + swot_analysis_comments_path(analysis)
    current_path.should == swot_analysis_comments_path(analysis)
  
    find_link I18n.t('views.swot.internals.title')
    find_link I18n.t('views.swot.externals.title')
  
    find_link I18n.t('views.common.controls.back')
  
    within('.title-bar p') do
      page.should have_content I18n.t('views.comments.commenting')
      page.should have_content analysis.content
    end
    
    should_contain_record_info_for(analysis)
    page.should have_content analysis.user.name
    page.should have_content I18n.l(analysis.updated_at, :format => :short)
  end

end

RSpec.configuration.include(SwotHelperMethods)

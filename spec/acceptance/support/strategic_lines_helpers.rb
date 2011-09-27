module StrategicLinesHelperMethods

  def should_have_initial_welcome_page_contents
    current_url.should == @sub_host + strategic_lines_path
    current_path.should == strategic_lines_path

    page.should have_content I18n.t('views.strategic_lines.index.empty.title')

    find_link I18n.t('views.strategic_lines.index.empty.controls.start')
  end
  
end

RSpec.configuration.include(StrategicLinesHelperMethods)

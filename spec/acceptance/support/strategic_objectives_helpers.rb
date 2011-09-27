module StrategicObjectivesHelperMethods

  def should_have_initial_welcome_page_contents
    current_url.should == @sub_host + strategic_objectives_path
    current_path.should == strategic_objectives_path

    page.should have_content I18n.t('views.strategic_objectives.index.empty.title')

    find_link I18n.t('views.strategic_objectives.index.empty.controls.start')
  end
  
end

RSpec.configuration.include(StrategicObjectivesHelperMethods)

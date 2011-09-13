require 'subdomain_guards'

module AnalysisControllerHelper
  include UserAssociationsHelper
  include SubdomainGuards
  
  def flash_message_for(analysis)
    case analysis.kind
      when Analysis.weakness then I18n.t('views.swot.internal_view.weaknesses.add.successful_save')
      when Analysis.strength then I18n.t('views.swot.internal_view.strengths.add.successful_save')
      when Analysis.opportunity then  I18n.t('views.swot.external_view.opportunities.add.successful_save')
      when Analysis.risk then  I18n.t('views.swot.external_view.risks.add.successful_save')
    end
  end
end

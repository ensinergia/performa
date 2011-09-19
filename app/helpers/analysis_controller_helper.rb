#encoding: utf-8
require 'subdomain_guards'

module AnalysisControllerHelper
  include UserAssociationsHelper
  include SubdomainGuards
  
  def flash_notice_for(analysis, active_record_context)
    context = active_record_context == :on_save ? 'save' : ''
    
    localized_model = localize(analysis)
    genre = localized_model == "Riesgo" ? "o" : "a"
    
    I18n.t("views.common.messages.#{context}.successful", :model => localized_model, :genre => genre)
  end
  
  def flash_alert_for(analysis, active_record_context)
    context = active_record_context == :on_save ? 'save' : ''
    
    localized_model = localize(analysis)
    connector = localized_model == "Riesgo" ? "éste" : "ésta"
    
    I18n.t("views.common.messages.#{context}.unsuccessful", :model => localized_model, :connector => connector)
  end
  
  def url_for_analysis(analysis)
    return analysis.is_internal? ? internal_swot_analyses_path : external_swot_analyses_path
  end
  
  def delete_confirmation_for(analysis)
    localized_model = localize(analysis)
    connector = localized_model == "Riesgo" ? "éste" : "ésta"
    
    I18n.t("views.common.messages.delete.confirm", :connector => connector, :model => localized_model)
  end
  
  private
  
  def localize(analysis)
    # I18n.locale
    case analysis.kind
      when Analysis.weakness then return I18n.t('views.swot.internals.types.weakness')
      when Analysis.strength then return I18n.t('views.swot.internals.types.strength')
      when Analysis.opportunity then return I18n.t('views.swot.externals.types.opportunity')
      when Analysis.risk then return I18n.t('views.swot.externals.types.risk')
    end
  end
end

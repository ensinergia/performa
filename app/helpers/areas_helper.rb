module AreasHelper
  
  def visual_permissions_for(person)
    dom_class = person.role?(Role.admin) || person.role?(Role.super_admin) ? "is-admin" : "is-not-admin"
    "<span class=\"#{dom_class}\">#{person.name}</span>".html_safe
  end
  
  def translated_permissions_for_select_for(person)
    positions=Position.all.inject({}) do |computed, position|
      element = I18n.t("views.positions.#{position.name}", :default => position.name.humanize)
      computed[element] = position.id
      computed
    end

    options_for_select(positions, person.position.id)
  end
end

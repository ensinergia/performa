module StrategicObjectivesHelper
  include UserAssociationsHelper
  def strategic_objective_include_strategic_line?(strategic_objective, strategic_line)
    strategic_objective.strategic_lines.include?(strategic_line)
  end
end

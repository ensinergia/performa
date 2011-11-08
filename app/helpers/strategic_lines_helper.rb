module StrategicLinesHelper
  include UserAssociationsHelper
  def strategic_line_include_strategic_objective?(strategic_line, strategic_objective)
    strategic_line.strategic_objectives.include?(strategic_objective)
  end
end

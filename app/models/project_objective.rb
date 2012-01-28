class ProjectObjective < ActiveRecord::Base
  belongs_to :project
  belongs_to :operative_objective
end

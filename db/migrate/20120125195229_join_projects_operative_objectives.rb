class JoinProjectsOperativeObjectives < ActiveRecord::Migration
    def self.up
    create_table :projects_operative_objectives, :id => false do |t|
      t.integer :project_id
      t.integer :operative_objective_id
      t.integer :percent
    end
  end

  def self.down
    drop_table :projects_operative_objectives
  end
end

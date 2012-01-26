class JoinProjectsOperativeObjectives < ActiveRecord::Migration
    def self.up
    create_table :operative_objectives_projects, :id => false do |t|
      t.integer :project_id
      t.integer :operative_objective_id
      t.integer :percent
    end
  end

  def self.down
    drop_table :operative_objectives_projects
  end
end

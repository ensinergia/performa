class CreateProjectObjectives < ActiveRecord::Migration
  def self.up
    drop_table :operative_objectives_projects
    
    create_table :project_objectives do |t|
      t.integer :project_id
      t.integer :operative_objective_id
      t.integer :percent
      t.timestamps
    end
  end

  def self.down
    drop_table :project_objectives
  end
end

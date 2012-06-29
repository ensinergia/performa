class CreateJoinOperativeCyclesWithOperativeObjectives < ActiveRecord::Migration
  def self.up
    drop_table :operating_cycles_strategic_lines
    create_table :operating_cycles_operative_objectives, :id => false do |t|
      t.integer :operative_objective_id
      t.integer :operating_cycle_id
    end
  end

  def self.down
    drop_table :operating_cycles_operative_objectives
  end
end

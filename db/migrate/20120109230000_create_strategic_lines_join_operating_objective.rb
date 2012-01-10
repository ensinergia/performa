class CreateStrategicLinesJoinOperatingObjective < ActiveRecord::Migration
  def self.up
    create_table :operative_objectives_strategic_lines, :id => false do |t|
      t.integer :strategic_line_id
      t.integer :operative_objective_id
    end
  end

  def self.down
    drop_table :operative_objectives_strategic_lines
  end
end

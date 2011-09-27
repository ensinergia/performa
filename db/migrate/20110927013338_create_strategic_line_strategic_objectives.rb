class CreateStrategicLineStrategicObjectives < ActiveRecord::Migration
  def self.up
    create_table :strategic_line_strategic_objectives do |t|
      t.integer :strategic_line_id
      t.integer :strategic_objective_id
    end
  end

  def self.down
    drop_table :strategic_line_strategic_objectives
  end
end

class CreateStrategicLinesJoinOperatingCycle < ActiveRecord::Migration
  def self.up
    create_table :operating_cycles_strategic_lines, :id => false do |t|
      t.integer :strategic_line_id
      t.integer :operating_cycle_id
    end
  end

  def self.down
    drop_table :operating_cycles_strategic_lines
  end
end

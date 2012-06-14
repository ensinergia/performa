class AddareaIdToStrategicLinesAndStrategicObjectives < ActiveRecord::Migration
  def self.up
    add_column :strategic_lines , :area_id, :integer
    add_column :strategic_objectives , :area_id, :integer
  end

  def self.down
    remove_column :strategic_lines , :area_id
    remove_column :strategic_objectives , :area_id
  end
end

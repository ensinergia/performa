class AddStrategicObjectiveIdToPointers < ActiveRecord::Migration
  def self.up
       add_column :pointers , :strategic_objective_id, :integer
  end

  def self.down
      remove_column :pointers , :strategic_objective_id
  end
end

class AddTorderToStrategicObjectives < ActiveRecord::Migration
   def self.up
    add_column :strategic_objectives, :torder, :integer

  end

  def self.down
    remove_column :strategic_objectives, :torder
  end
end

class RenameOperatingCyclesIdToOperatingCycleId < ActiveRecord::Migration
  def self.up
    rename_column :clients, :operating_cycles_id, :operating_cycle_id 
    rename_column :services, :operating_cycles_id, :operating_cycle_id 
    
  end

  def self.down
     rename_column :clients, :operating_cycle_id, :operating_cycles_id 
      rename_column :services, :operating_cycle_id, :operating_cycles_id 
   
  end
end

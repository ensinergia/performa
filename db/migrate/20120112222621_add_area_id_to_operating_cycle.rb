class AddAreaIdToOperatingCycle < ActiveRecord::Migration
  def self.up
    add_column :operating_cycles, :area_id, :integer
  end

  def self.down
    remove_column :operating_cycles, :area_id
  end
end

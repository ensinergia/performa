class AddTorderToOperativeCycle < ActiveRecord::Migration
  def self.up
    add_column :operating_cycles, :torder, :integer

  end

  def self.down
    remove_column :operating_cycles, :torder
  end
end

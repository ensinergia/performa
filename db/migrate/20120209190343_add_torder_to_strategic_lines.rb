class AddTorderToStrategicLines < ActiveRecord::Migration
  def self.up
    add_column :strategic_lines, :torder, :integer

  end

  def self.down
    remove_column :strategic_lines, :torder
  end
end

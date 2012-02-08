class AddTorderToOperativeObjectives < ActiveRecord::Migration
   def self.up
    add_column :operative_objectives, :torder, :integer

  end

  def self.down
    remove_column :operative_objectives, :torder
  end
end

class AddTorderToProjects < ActiveRecord::Migration
   def self.up
    add_column :projects, :torder, :integer

  end

  def self.down
    remove_column :projects, :torder
  end
end

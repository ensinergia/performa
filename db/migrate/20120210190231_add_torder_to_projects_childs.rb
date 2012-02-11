class AddTorderToProjectsChilds < ActiveRecord::Migration
  def self.up
    add_column :profits, :torder, :integer
    add_column :liabilities, :torder, :integer
    add_column :restrictions, :torder, :integer
    add_column :project_objectives, :torder, :integer

  end

  def self.down
    remove_column :profits, :torder
    remove_column :liabilities, :torder
    remove_column :restrictions, :torder
    remove_column :project_objectives, :torder
  end
end

class AddDateToProjectTasks < ActiveRecord::Migration
  def self.up
    add_column :project_tasks, :date, :date
  end

  def self.down
    remove_column :project_tasks, :date
  end
end

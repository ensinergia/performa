class AddProjectIdToPointers < ActiveRecord::Migration
   def self.up
       add_column :pointers , :project_id, :integer
  end

  def self.down
      remove_column :pointers , :project_id
  end

end

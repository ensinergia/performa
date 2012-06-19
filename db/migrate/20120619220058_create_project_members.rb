class CreateProjectMembers < ActiveRecord::Migration
  def self.up
    create_table :project_members do |t|
       t.references :user
        t.references :project
        t.string :role
        t.integer :torder
      t.timestamps
    end
  end

  def self.down
    drop_table :project_members
  end
end

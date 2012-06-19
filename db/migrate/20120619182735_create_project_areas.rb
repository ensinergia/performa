class CreateProjectAreas < ActiveRecord::Migration
  def self.up
    create_table :project_areas do |t|
       t.references :area
        t.references :project
        t.integer :torder
      t.timestamps
    end
  end

  def self.down
    drop_table :project_areas
  end
end

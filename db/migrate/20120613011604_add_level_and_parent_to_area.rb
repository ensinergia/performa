class AddLevelAndParentToArea < ActiveRecord::Migration
  def self.up
    add_column :areas, :parent_id, :integer
    add_column :areas, :alevel, :integer
  end

  def self.down
    remove_column :areas, :parent_id
    remove_column :areas, :alevel
  end
end

class AddStatusToPointer < ActiveRecord::Migration
  def self.up
    add_column :pointers, :status, :float
  end

  def self.down
    remove_column :pointer, :status
  end
end

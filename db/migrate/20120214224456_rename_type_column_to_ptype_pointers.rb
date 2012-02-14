class RenameTypeColumnToPtypePointers < ActiveRecord::Migration
  def self.up
    rename_column :pointers, :type, :ptype 
  end

  def self.down
     rename_column :pointers, :ptype, :type 
    
  end
end

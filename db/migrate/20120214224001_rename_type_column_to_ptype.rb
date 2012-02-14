class RenameTypeColumnToPtype < ActiveRecord::Migration
  def self.up
    rename_column :projects, :type, :ptype 
  end

  def self.down
     rename_column :projects, :ptype, :type 
    
  end
end

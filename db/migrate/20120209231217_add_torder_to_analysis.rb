class AddTorderToAnalysis < ActiveRecord::Migration
   def self.up
    add_column :analyses, :torder, :integer

  end

  def self.down
    remove_column :analyses, :torder
  end
end

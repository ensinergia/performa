class AddNewfieldTopointers < ActiveRecord::Migration
  def self.up
    add_column :pointers, :unit, :string
    add_column :pointers, :algorithm, :text
  end

  def self.down
    remove_column :pointers, :unit
    remove_column :pointers, :algorithm
  end
end

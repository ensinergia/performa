class ChanceStringDescriptionToText < ActiveRecord::Migration
  def self.up
    change_column :creeds, :description, :text
    change_column :operative_objectives, :actions, :text
    change_column :operative_objectives, :results, :text
    change_column :pointers, :description, :text
    
  end

  def self.down
      change_column :creeds, :description, :string
      change_column :operative_objectives, :actions, :string
      change_column :operative_objectives, :results, :string
      change_column :pointers, :description, :string
  end
end

class AddResponsableToOperativeObjective < ActiveRecord::Migration
  def self.up
    add_column :operative_objectives, :responsable_id, :integer
  end

  def self.down
    remove_column :operative_objectives, :responsable_id
  end
end

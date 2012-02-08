class AddOrderToStepsAndStages < ActiveRecord::Migration
  def self.up
    add_column :stages, :torder, :integer
    add_column :steps, :torder, :integer
  end

  def self.down
    remove_column :steps, :torder
    remove_column :stages, :torder
  end
end

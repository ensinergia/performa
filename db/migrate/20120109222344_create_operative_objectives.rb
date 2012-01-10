class CreateOperativeObjectives < ActiveRecord::Migration
  def self.up
    create_table :operative_objectives do |t|
      t.string :results
      t.string :actions
      t.string :perspective
      t.integer :area_id
      t.integer :user_id
      t.timestamps :init_date
      t.timestamps :final_date
      t.timestamps
    end
  end

  def self.down
    drop_table :operative_objectives
  end
end

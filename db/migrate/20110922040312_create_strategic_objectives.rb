class CreateStrategicObjectives < ActiveRecord::Migration
  def self.up
    create_table :strategic_objectives do |t|
      t.string :content
      t.integer :user_id
      t.integer :company_id

      t.timestamps
    end
  end

  def self.down
    drop_table :strategic_objectives
  end
end

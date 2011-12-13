class CreateKeyActivities < ActiveRecord::Migration
  def self.up
    create_table :key_activities do |t|
      t.string :name
      t.integer :operating_cycles_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :key_activities
  end
end

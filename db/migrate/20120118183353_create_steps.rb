class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.string :name
      t.integer :stage_id
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end

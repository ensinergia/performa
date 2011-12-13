class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.string :name
      t.integer :operating_cycles_id
      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end

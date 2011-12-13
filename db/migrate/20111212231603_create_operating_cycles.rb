class CreateOperatingCycles < ActiveRecord::Migration
  def self.up
    create_table :operating_cycles do |t|
      t.string  :name
      t.text    :reason
      t.integer :internal_id
      t.integer :user_id
      t.integer :company_id
      t.timestamps
    end
  end

  def self.down
    drop_table :operating_cycles
  end
end

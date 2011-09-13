class CreateSwots < ActiveRecord::Migration
  def self.up
    create_table :swots do |t|
      t.integer :company_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :swots
  end
end

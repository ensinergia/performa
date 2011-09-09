class CreateCreeds < ActiveRecord::Migration
  def self.up
    create_table :creeds do |t|
      t.string :description
      t.integer :company_id
      t.integer :user_id
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :creeds
  end
end

class CreateVisions < ActiveRecord::Migration
  def self.up
    create_table :visions do |t|
      t.string :description
      t.integer :company_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :visions
  end
end

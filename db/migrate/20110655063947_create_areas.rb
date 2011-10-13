class CreateAreas < ActiveRecord::Migration
  def self.up
    create_table :areas do |t|
      t.string :name
      t.integer :company_id
      t.boolean :is_root_area
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :areas
  end
end

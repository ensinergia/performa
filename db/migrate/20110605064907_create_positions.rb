class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table :positions do |t|
      t.string :name
      t.integer :role_equivalence
    end
  end

  def self.down
    drop_table :positions
  end
end

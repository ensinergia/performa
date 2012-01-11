class CreatePointers < ActiveRecord::Migration
  def self.up
    create_table :pointers do |t|
      t.integer :operative_objective_id
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :perspective
      t.string :type
      t.string :file
      t.string :advance_type
      t.string :behavior
      t.string :periodicity
      t.string :reajust_to_cero
      t.string :ini_value
      t.datetime :init_date
      t.string :thresholds
      t.string :advance
      t.string :goals
      t.string :results
      t.string :comments
      t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :pointers
  end
end

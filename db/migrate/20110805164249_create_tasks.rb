class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :description
      t.integer :priority
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end

class CreateLiabilities < ActiveRecord::Migration
  def self.up
    create_table :liabilities do |t|
      t.indeger   :project_id
      t.string    :name
      t.boolean   :increment
      t.boolean   :decrement
      t.timestamps
    end
  end

  def self.down
    drop_table :liabilities
  end
end

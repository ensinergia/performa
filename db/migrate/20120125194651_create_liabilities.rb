class CreateLiabilities < ActiveRecord::Migration
  def self.up
    create_table :liabilities do |t|
      t.integer   :project_id
      t.string    :name
      t.timestamps
    end
  end

  def self.down
    drop_table :liabilities
  end
end

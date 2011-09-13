class CreateAnalyses < ActiveRecord::Migration
  def self.up
    create_table :analyses do |t|
      t.string :content
      t.integer :kind
      t.integer :user_id
      t.integer :swot_id

      t.timestamps
    end
  end

  def self.down
    drop_table :analyses
  end
end

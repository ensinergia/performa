class CreateProfits < ActiveRecord::Migration
  def self.up
    create_table :profits do |t|
      t.integer   :project_id
      t.string    :name
      t.boolean   :incre
      t.boolean   :decre
      t.timestamps
    end
  end

  def self.down
    drop_table :profits
  end
end

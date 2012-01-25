class CreateRestrictions < ActiveRecord::Migration
  def self.up
    create_table :restrictions do |t|
      t.indeger   :project_id
      t.string    :name
      t.timestamps
    end
  end

  def self.down
    drop_table :restrictions
  end
end

class CreateContextualLegends < ActiveRecord::Migration
  def self.up
    create_table :contextual_legends do |t|
      t.text :content
      t.string :url

      t.timestamps
    end
    
    execute "ALTER TABLE contextual_legends ADD CONSTRAINT contextual_legends_index
              UNIQUE(url, id)"
  end

  def self.down
    drop_table :contextual_legends
  end
end

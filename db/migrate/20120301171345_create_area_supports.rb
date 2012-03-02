class CreateAreaSupports < ActiveRecord::Migration
  def self.up
    create_table :area_supports do |t|
      t.integer   :area_id
      t.integer   :supported_id
      t.integer   :torder
      t.timestamps
    end
  end

  def self.down
    drop_table :area_supports
  end
end

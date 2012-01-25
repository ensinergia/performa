class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table  :projects do |t|
      t.integer   :area_id
      t.integer   :user_id
      t.integer   :company_id
      t.string    :name
      t.text      :description
      t.string    :type
      t.text      :reason
      t.integer   :leader_id
      t.string    :length
      t.datetime  :init_date
      t.datetime  :final_date
      t.text      :product
      t.string    :investment
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end

class AddtypeTorestrictions < ActiveRecord::Migration
  def self.up
    add_column :restrictions, :ptype, :string
  end

  def self.down
    remove_column :restrictions, :ptype
  end
end

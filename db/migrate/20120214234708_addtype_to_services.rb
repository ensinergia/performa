class AddtypeToServices < ActiveRecord::Migration
   def self.up
    add_column :services, :ptype, :string
  end

  def self.down
    remove_column :services, :ptype
  end
end

class AddTorderToClientsAndServices < ActiveRecord::Migration
  def self.up
    add_column :clients, :torder, :integer
    add_column :services, :torder, :integer
  end

  def self.down
    remove_column :clients, :torder
    remove_column :services, :torder
  end
end

class AddtypeToprofits < ActiveRecord::Migration
def self.up
    add_column :profits, :ptype, :string
    remove_column :profits, :incre
    remove_column :profits, :decre
    
  end

  def self.down
    remove_column :profits, :ptype
    add_column :profits, :ptype, :boolean
    add_column :profits, :ptype, :boolean
  end
end

class AddExtraFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :grade, :string
    add_column :users, :officce_phone, :string
    add_column :users, :ext_phone, :string
    add_column :users, :celular_phone, :string
    add_column :users, :home_phone, :string
    add_column :users, :fax, :string
  end

  def self.down
    remove_column :users, :grade
    remove_column :users, :officce_phone
    remove_column :users, :ext_phone
    remove_column :users, :celular_phone
    remove_column :users, :home_phone
    remove_column :users, :fax
  end
end

# encoding: utf-8

Factory.define :user do |u|
  u.name "Silvano"
  u.company_name "iEvolutioned"
  u.last_name "Barba"
  u.password "performa"
  u.password_confirmation "performa"
  u.email "silvanito@ievolutioned.com"
  u.position { Factory(:position, :name => Position.owner) }
end

Factory.define :user_no_company_name, :class => "User" do |u|
  u.name "Fulano tal"
  u.last_name "Pérez"
  u.password "performa"
  u.password_confirmation "performa"
  u.sequence :email do |n|
    "fulano#{n}@ievolutioned.com"
  end
  u.position { Factory(:position, :name => Position.employee) }
end

Factory.define :user_no_company_name_other_area, :class => "User" do |u|
  u.name "Perengano"
  u.last_name "Pérez"
  u.password "performa"
  u.password_confirmation "performa"
  u.company { Factory(:company_sequenced) }
  u.area { Factory(:area, :name => "Another", :company => company) }
  u.sequence :email do |n|
    "perengano#{n}@ievolutioned.com"
  end
  u.position { Factory(:position, :name => Position.employee) }
end

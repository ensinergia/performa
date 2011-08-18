# encoding: utf-8

Factory.define :user do |u|
  u.name "Silvano"
  u.company_name "iEvolutioned"
  u.last_name "Barba"
  u.password "performa"
  u.password_confirmation "performa"
  u.email "silvanito@ievolutioned.com"
end

Factory.define :user_no_company_name, :class => "User" do |u|
  u.name "Fulano tal"
  u.last_name "Pérez"
  u.password "performa"
  u.password_confirmation "performa"
  u.sequence :email do |n|
    "fulano#{n}@ievolutioned.com"
  end
end
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role_admin, :class => "Role" do
    name "admin"
  end
  
  factory :role_user, :class => "Role" do
    name "user"
  end
end
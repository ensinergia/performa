# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do 
    name "some"
  end
  
  factory :owner_position, :class => "Position" do
      name "owner"
      role_equivalence Role.super_admin
  end
  
  factory :user_position, :class => "Position" do
      name "user"
      role_equivalence Role.user
  end
end
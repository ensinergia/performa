# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vision do
    description "A short company vision"
  end
  
  factory :vision_with_assoc, :class => :vision do
    description "A short company vision"
    company { Factory(:company_sequenced) }
    user { Factory(:user_no_company_name, :company => company) }
  end
end
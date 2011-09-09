# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :war_cry do
    description "A short company vision"
  end
  
  factory :war_cry_with_assoc, :class => :war_cry do
    description "A short company vision"
    company { Factory(:company_sequenced) }
    user { Factory(:user_no_company_name, :company => company) }
  end
end
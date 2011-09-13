# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :creed do
    description "A simple creed record"
  end
  
  factory :creed_with_assoc, :class => :creed do
    description "A simple creed record"
    company { Factory(:company_sequenced) }
    user { Factory(:user_no_company_name, :company => company) }
  end
end
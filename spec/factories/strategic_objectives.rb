# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strategic_objective do
    content "A simple objective"
    company { Factory(:company_sequenced) }
    user { Factory(:user_no_company_name, :company => company) }
  end
end

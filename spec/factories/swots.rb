# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :swot do
    company { Factory(:company_sequenced) }
  end
end
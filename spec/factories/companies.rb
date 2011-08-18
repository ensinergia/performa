# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "iEvolutioned"
  end
  
  factory :company_sequenced, :class => :company do
    sequence :name do |n|
      "Company {n}"
    end
  end
end
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    content File.open(File.join(Rails.root,"spec", "helper_assets","example.html"))
  end
end
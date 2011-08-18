# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
      description "A task"
      priority Task.high_priority
  end
end
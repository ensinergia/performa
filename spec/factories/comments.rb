# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
      content "MyString"
      user_id 1
      commentable_id 1
      commentable ""
    end
end
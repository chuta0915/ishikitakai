# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :wiki do
    parent_type "MyString"
    parent_id 1
    user_id 1
    name "MyString"
    content "MyText"
  end
end

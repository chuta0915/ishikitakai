# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    group_id 1
    name "MyString"
    done false
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user_id 1
    type ""
    name "MyString"
    content "MyText"
    read_at "2012-09-05 14:48:32"
  end
end

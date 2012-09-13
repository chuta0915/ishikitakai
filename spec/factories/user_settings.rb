# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_setting do
    user_id 1
    mail_attend_status false
  end
end

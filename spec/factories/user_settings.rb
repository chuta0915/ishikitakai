# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_setting, class: 'UserSetting' do
    mail_attend_status false
    mail_event_comment false
  end
end

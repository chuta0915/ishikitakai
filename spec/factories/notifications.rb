# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification_basic, class: 'Notification' do
    type "Notification::Basic"
    name "Mail address is empty"
    content "Confirm your email address setting"
    read_at nil
  end
end

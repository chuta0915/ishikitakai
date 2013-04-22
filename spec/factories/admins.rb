# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin, class: 'Admin' do
    name "ppworks"
    email "koshikawa@ppworks.jp"
    password "password"
    password_confirmation "password"
  end
end

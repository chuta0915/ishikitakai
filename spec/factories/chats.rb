# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :chat, class: 'Chat' do
    content "Chat Message"
  end
end

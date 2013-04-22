# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment, class: 'Comment' do
    content "Comment Content"
  end
end

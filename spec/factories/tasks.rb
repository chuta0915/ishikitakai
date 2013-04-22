# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task, class: 'Task' do
    group_id 1
    name "remember the milk"
    done false
  end
end

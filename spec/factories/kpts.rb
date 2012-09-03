# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kpt, class: Kpt do
    name "any idea"
    status Kpt::KEEP
  end
  factory :kpt_keep, class: Kpt do
    name "keep"
    status Kpt::KEEP
  end
  factory :kpt_problem, class: Kpt do
    name "problem"
    status Kpt::PROBLEM
  end
  factory :kpt_try, class: Kpt do
    name "try"
    status Kpt::TRY
  end
end

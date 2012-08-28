# encoding: utf-8
FactoryGirl.define do
  factory :sendagayarb, class: Group do
    name "sednagaya.rb"
    content "# sendagaya.rb\n* test\n* hoge\n* fugo\n\nゆるふわ"
    summary "ゆるふわ会"
    scope_id 1
  end
  factory :ishikitakai, class: Group do
    name "ishikitakai"
    content "# ishikitakai.rb\n* test\n* hoge\n* fugo\n\n意識高い"
    summary "意識た会"
    scope_id 4
  end
end

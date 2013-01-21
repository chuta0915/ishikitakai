# encoding: utf-8
FactoryGirl.define do
  factory :mokmok_event, class: Event do
    user_id 1
    group_id 1
    scope_id 1
    name "Sendagaya.rb mokmok Day"
    content "# sendagaya.rb\n* test\n* hoge\n* fugo\n\nゆるふわ"
    summary "mokmok"
    place_url "http://www.connectstar.co.jp"
    place_name "connectstar"
    place_address "〒151-0051 東京都渋谷区千駄ヶ谷1-13-11 チャリ千駄ヶ谷202"
    place_map_url "http://maps.google.co.jp/maps?q=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B71-13-11&hl=ja&ie=UTF8&sll=35.682049,139.707332&sspn=0.027259,0.032659&brcurrent=3,0x60188cbe2fdaeaf9:0x8eb374503b87af3f,0&hnear=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B7%EF%BC%91%E4%B8%81%E7%9B%AE%EF%BC%91%EF%BC%93%E2%88%92%EF%BC%91%EF%BC%91&t=m&z=17"
    capacity_min 1
    capacity_max 8
    begin_at "2012-05-21 19:30:00"
    end_at "2012-05-21 21:30:00"
    receive_begin_at "2012-05-18 12:00:00"
    receive_end_at "2012-05-21 18:00:00"
    event_payment_kind_id 1
    fee 0
  end
  factory :reading_event, class: Event do
    user_id 1
    group_id 1
    scope_id 1
    name "Sendagaya.rb reading Day"
    content "# sendagaya.rb\n* test\n* hoge\n* fugo\n\nゆるふわ"
    summary "reading"
    place_url "http://www.connectstar.co.jp"
    place_name "connectstar"
    place_address "〒151-0051 東京都渋谷区千駄ヶ谷1-13-11 チャリ千駄ヶ谷202"
    place_map_url "http://maps.google.co.jp/maps?q=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B71-13-11&hl=ja&ie=UTF8&sll=35.682049,139.707332&sspn=0.027259,0.032659&brcurrent=3,0x60188cbe2fdaeaf9:0x8eb374503b87af3f,0&hnear=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B7%EF%BC%91%E4%B8%81%E7%9B%AE%EF%BC%91%EF%BC%93%E2%88%92%EF%BC%91%EF%BC%91&t=m&z=17"
    capacity_min 1
    capacity_max 8
    begin_at "2012-05-28 19:30:00"
    end_at "2012-05-28 21:30:00"
    receive_begin_at "2012-06-04 12:00:00"
    receive_end_at "2012-06-04 18:00:00"
    event_payment_kind_id 1
    fee 0
  end

  factory :private_event, class: Event do
    user_id 1
    group_id 1
    scope_id 1
    name "private event"
    content "private event!"
    summary "himitsu"
    place_url "http://www.connectstar.co.jp"
    place_name "connectstar"
    place_address "〒151-0051 東京都渋谷区千駄ヶ谷1-13-11 チャリ千駄ヶ谷202"
    place_map_url "http://maps.google.co.jp/maps?q=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B71-13-11&hl=ja&ie=UTF8&sll=35.682049,139.707332&sspn=0.027259,0.032659&brcurrent=3,0x60188cbe2fdaeaf9:0x8eb374503b87af3f,0&hnear=%E6%9D%B1%E4%BA%AC%E9%83%BD%E6%B8%8B%E8%B0%B7%E5%8C%BA%E5%8D%83%E9%A7%84%E3%83%B6%E8%B0%B7%EF%BC%91%E4%B8%81%E7%9B%AE%EF%BC%91%EF%BC%93%E2%88%92%EF%BC%91%EF%BC%91&t=m&z=17"
    capacity_min 1
    capacity_max 8
    begin_at "2012-05-28 19:30:00"
    end_at "2012-05-28 21:30:00"
    receive_begin_at "2012-06-04 12:00:00"
    receive_end_at "2012-06-04 18:00:00"
    event_payment_kind_id 1
    fee 0
  end

  factory :new_event, class: Event do
    group_id  ""
    name  "event name"
    summary  "説明"
    content  "カイサイしまーす"
    place_name  "ギロッポン"
    place_url  "http://example.com/"
    place_address  "六本木駅"
    capacity_min  "1"
    capacity_max  "5"
    receive_begin_date  "2012-10-28"
    receive_begin_time  "07:00"
    receive_end_date  "2012-10-28"
    receive_end_time  "08:00"
    begin_date  "2012-10-28"
    begin_time  "09:00"
    end_date  "2012-10-28"
    end_time  "10:00"
    event_payment_kind_id  "1"
    fee  "100"
    scope_id  "1"
  end
end

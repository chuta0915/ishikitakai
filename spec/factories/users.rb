# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'ppworks'
    image 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
    email '90558020@twitter.example.com'
    providers_users {[
      ProvidersUser.new(
        provider_id: Provider.twitter.id, 
        user_key: "12345",
        access_token: Faker::Lorem.words(1)[0],
        name: 'ppworks',
        image: 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
      )
    ]}
  end
  
  factory :new_user, class: User do
    name 'ppworks2'
    image 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
    email 'xxx@twitter.example.com'
  end

  factory :friend, class: User do
    name 'naoto5959'
    image 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
    email '90558022@twitter.example.com'
    providers_users {[
      ProvidersUser.new(
        provider_id: Provider.twitter.id, 
        user_key: "12346",
        access_token: Faker::Lorem.words(1)[0],
        name: 'naoto5959',
        image: 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
      )
    ]}
  end

  factory :other_user, class: User do
    name 'xxxxYYYY'
    image 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
    email '123456789@twitter.example.com'
    providers_users {[
      ProvidersUser.new(
        provider_id: Provider.twitter.id, 
        user_key: "123456789",
        access_token: Faker::Lorem.words(1)[0],
        name: 'xxxxYYYY',
        image: 'http://a1.twimg.com/profile_images/1805350696/twitter_icon_20101007_06_normal.png'
      )
    ]}
  end
end

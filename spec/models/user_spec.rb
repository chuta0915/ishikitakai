require 'spec_helper'

describe User do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create(:user) }
  let(:new_user) { FactoryGirl.build(:new_user) }
  let(:friend) { FactoryGirl.create(:friend) }
  let(:auth) {
    {
      'uid' => '123456',
      'info' => {
        'name' => new_user.name,
        'nickname' => new_user.name,
        'image' => new_user.image,
        'email' => new_user.email,
      },
      'credentials' => {
        'token' => 'token',
        'secret' => 'secret'
      },
      'extra' => {
        'raw_info' => {
          'avatar_url' => new_user.image
        }
      }
    }
  }
  
  describe 'User instance' do
    it { user.should be_instance_of User }
  end
  describe 'facebook login' do
    it { User.find_facebook(auth, nil).should be_present }
  end
  describe 'twitter login' do
    it { User.find_twitter(auth, nil).should be_present }
  end
end
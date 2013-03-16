require 'spec_helper'

describe User do
  ancestors_should_include ActiveRecord::Base
  let(:user) { create(:user) }
  let(:new_user) { build(:new_user) }
  let(:friend) { create(:friend) }
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
  describe 'github login' do
    it { User.find_github(auth, nil).should be_present }
  end

  describe 'storable' do
    subject { new_user }
    before do
      User.any_instance.unstub(:save_to_s3)
      storage = Fog::Storage.new(
        provider: 'AWS',
        aws_access_key_id:'test',
        aws_secret_access_key:'test',
        region: 'test'
      )
      Fog::Storage.stub(:new).and_return(storage)
      Fog::Storage::AWS::Directories.any_instance.stub(:get).and_return(nil)
    end
    context 'not saved' do
      it { subject.image.should =~ /twitter/ }
    end
    context 'saved' do
      before do
        /s3\.amazonaws\.com\/users\/image\/1/
        new_user.save
        new_user.reload
      end
      it "has correct image url" do
        # TODO somehow it returns url with double slashes "https://s3.amazonaws.com//users/image/1/1?1363446084"
        subject.image.should =~ %r{s3\.amazonaws\.com}
        subject.image.should =~ %r{users/image/#{new_user.id}}
      end
    end
  end
end

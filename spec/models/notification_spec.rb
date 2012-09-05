require 'spec_helper'

describe Notification do
  let(:user) { FactoryGirl.create :user }
  let!(:notification) { FactoryGirl.create :notification_basic, user: user }

  describe "read it" do
    let (:current) { Time.current }
    subject { notification }
    context "not yet read" do
      it { subject.read.should be_false }
      it { subject.read_at.should be_nil }
      it { user.notifications.not_yet_read.all.should have(1).items }
    end
    context "read" do
      before do
        notification.read_it
      end
      it { subject.read.should be_true }
      it { subject.read_at.to_s.should >= current.to_s }
      it { user.notifications.all.should have(1).items }
      it { user.notifications.not_yet_read.all.should have(0).items }
    end
  end

  describe "notify" do
    subject { user.notifications.last }
    before do
      Notification.notify [user], { name: 'name', content: 'content' }, user
    end
    it { subject.trigger_type.should == 'User' }
    it { subject.trigger_id.should == user.id }
    it { subject.name.should == 'name' }
    it { subject.content.should == 'content' }
    it { subject.read.should be_false }
    it { subject.read_at.should be_nil }
  end
end

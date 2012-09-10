require 'spec_helper'

describe Event do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create :user }
  let(:friend) { FactoryGirl.create :friend }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }
  let(:master) { Level.find 1 }

  describe "after create" do
    subject { event }
    it { subject.attendences.should have(1).items }
    it { subject.attendences[0].level.id.should == master.id }
  end

  describe "notify " do
    context "when capacity_max is changed" do
      before do
        event.capacity_max = 1
        event.save
        event.join friend.id
        event.capacity_max = 2
        event.save
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::AttendStatus' }
    end
  end
end

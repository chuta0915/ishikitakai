#coding: utf-8
require 'spec_helper'

describe Event do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create :user }
  let(:friend) { FactoryGirl.create :friend }
  let(:other_user) { FactoryGirl.create :other_user }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }
  let(:master) { Level.find 1 }
  let(:valid_paramter) {
    {
     :group_id => "",
     :name => "event name",
     :summary => "説明",
     :content => "カイサイしまーす",
     :place_name => "ギロッポン",
     :place_url => "http://example.com/",
     :place_address => "六本木駅",
     :capacity_min => "1",
     :capacity_max => "5",
     :receive_begin_date => "2012-10-28",
     :receive_begin_time => "07:00",
     :receive_end_date => "2012-10-28",
     :receive_end_time => "08:00",
     :begin_date => "2012-10-28",
     :begin_time => "09:00",
     :end_date => "2012-10-28",
     :end_time => "10:00",
     :event_payment_kind_id => "1",
     :fee => "100",
     :scope_id => "1"
    }
  }

  describe "when new" do
    before do
      @event = Event.new(valid_paramter)
    end
    subject { @event }
    context "model new" do
      it {subject.begin_at.should eq Time.zone.parse '2012-10-28 09:00' }
      it {subject.end_at.should   eq Time.zone.parse '2012-10-28 10:00' }
      it {subject.receive_begin_at.should eq Time.zone.parse '2012-10-28 07:00' }
      it {subject.receive_end_at.should   eq Time.zone.parse '2012-10-28 08:00' }
    end
    context "after save" do
      before {@event.save}
      it {subject.begin_at.should eq Time.zone.parse '2012-10-28 09:00' }
      it {subject.end_at.should   eq Time.zone.parse '2012-10-28 10:00' }
      it {subject.receive_begin_at.should eq Time.zone.parse '2012-10-28 07:00' }
      it {subject.receive_end_at.should   eq Time.zone.parse '2012-10-28 08:00' }
    end
  end

  describe "when update" do
    before do
      @event = Event.new(valid_paramter)
      @event.save
      @event.attributes = valid_paramter.merge(:end_date => "2012-10-29")
    end
    subject { @event }
    context "set update attributes" do
      pending("値の設定時は*_date, *_time*_atに値が反映されないが使用しないので保留")
      #it { subject.begin_at.should eq Time.zone.parse '2012-10-28 09:00' }
      #it { subject.end_at.should   eq Time.zone.parse '2012-10-29 10:00' }
      #it { subject.receive_begin_at.should eq Time.zone.parse '2012-10-28 07:00' }
      #it { subject.receive_end_at.should   eq Time.zone.parse '2012-10-28 08:00' }
    end
    context "after save for update" do
      before { @event.save }
      it { subject.begin_at.should eq Time.zone.parse '2012-10-28 09:00' }
      it { subject.end_at.should   eq Time.zone.parse '2012-10-29 10:00' }
      it { subject.receive_begin_at.should eq Time.zone.parse '2012-10-28 07:00' }
      it { subject.receive_end_at.should   eq Time.zone.parse '2012-10-28 08:00' }
    end
  end

  describe "after create" do
    subject { event }
    it { subject.attendences.should have(1).items }
    it { subject.attendences[0].level.id.should == master.id }
  end

  describe "notify " do
    context "when capacity_max is changed" do
      before do
        ActionMailer::Base.deliveries = []
        event.capacity_max = 1
        event.save
        event.join friend.id
        event.capacity_max = 2
        event.save
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::AttendStatus' }
      it { ActionMailer::Base.deliveries.size.should == 1 }
    end

    context "when leave event" do
      before do
        ActionMailer::Base.deliveries = []
        event.capacity_max = 2
        event.save
        event.join other_user.id
        event.join friend.id
        event.leave other_user.id
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::AttendStatus' }
      it { ActionMailer::Base.deliveries.size.should == 1 }
    end
  end
end

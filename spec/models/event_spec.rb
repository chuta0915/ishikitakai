#coding: utf-8
require 'spec_helper'

describe Event do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create :user }
  let(:friend) { FactoryGirl.create :friend }
  let(:other_user) { FactoryGirl.create :other_user }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }
  let(:master) { Level.find 1 }
  let(:valid_paramter) { FactoryGirl.attributes_for :new_event }

  describe 'search scope' do
    let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
    let!(:ishikitakai) { FactoryGirl.create :ishikitakai, user_id: user.id }
    let!(:event) { FactoryGirl.create :mokmok_event, user: user, group_id: sendagayarb.id }
    let!(:private_event) { FactoryGirl.create :private_event, user: user, group_id: ishikitakai.id }
    subject { Event.search(keyword).first }
    context 'when passed "sendagaya"' do
      let(:keyword) { 'sendagaya' }
      its(:id) { should == event.id }
    end
    context 'when passed "tokyo"' do
      let(:keyword) { 'tokyo' }
      it { should be_blank }
    end
    context 'when passed "private"' do
      let(:keyword) { 'private' }
      it { should be_blank }
    end
  end

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
    it { subject.attendances.should have(1).items }
    it { subject.attendances[0].level.id.should == master.id }
  end

  describe "notify " do
    context "when capacity_max is changed" do
      before do
        ActionMailer::Base.deliveries = []
        event.capacity_max = 1
        event.save
        event.join friend
        event.capacity_max = 2
        event.save
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::AttendStatus' }
      it { user.notifications.should have(1).items }
      it { user.notifications[0].type.should == 'Notification::EventAttendance' }
      it { ActionMailer::Base.deliveries.size.should == 2 }
    end

    context "when leave event" do
      before do
        ActionMailer::Base.deliveries = []
        event.capacity_max = 2
        event.save
        event.join other_user
        event.join friend
        event.leave other_user
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::AttendStatus' }
      it { user.notifications.should have(2).items }
      it { user.notifications[0].type.should == 'Notification::EventAttendance' }
      it { user.notifications[1].type.should == 'Notification::EventAttendance' }
      it { other_user.notifications.should have(1).items }
      it { other_user.notifications[0].type.should == 'Notification::EventAttendance' }
      it { ActionMailer::Base.deliveries.size.should == 4 }
    end

    context "when added group's event" do
      let(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
      before do
        sendagayarb.join friend
        ActionMailer::Base.deliveries = []
        event = FactoryGirl.create :mokmok_event, user_id: user.id, group_id: sendagayarb.id
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::GroupEvent' }
      it { ActionMailer::Base.deliveries.size.should == 1 }
    end

    context "when added none group's event" do
      let(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
      before do
        sendagayarb.join friend
        ActionMailer::Base.deliveries = []
        event = FactoryGirl.create :mokmok_event, user_id: user.id, group_id: nil
      end
      it { friend.notifications.should have(0).items }
      it { ActionMailer::Base.deliveries.size.should == 0 }
    end
  end

  describe 'join' do
    let(:master_user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:other_user) }
    let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: master_user.id }
    before do
    end
    context "group member joins group's event" do
      let!(:event) { FactoryGirl.create :mokmok_event, user_id: master_user.id }
      subject { event.attendances.where(user_id: other_user.id).last }
      before do
        sendagayarb.join other_user, 'member'
        event.join other_user
      end
      it { subject.level.should == Level.find_by_name('member') }
    end
    context "group master joins group's event which created by other master user" do
      let!(:event) { FactoryGirl.create :mokmok_event, user_id: other_user.id }
      subject { event.attendances.where(user_id: master_user.id).last }
      before do
        sendagayarb.join other_user, 'master'
        event.join master_user
      end
      it { subject.level.should == Level.find_by_name('master') }
    end 
    context "none group master joins group's event" do
      let!(:event) { FactoryGirl.create :mokmok_event, user_id: master_user.id }
      subject { sendagayarb.memberships.where(user_id: other_user.id).last }
      before do
        event.join other_user
      end
      it { subject.should be_present }
    end
  end
end

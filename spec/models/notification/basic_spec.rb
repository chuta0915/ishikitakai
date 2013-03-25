require 'spec_helper'

describe Notification::Basic do
  let(:user) { create :user }

  describe "notify_by_key" do
    subject { user.notifications.last }
    before do
      I18n.locale = :en
      Notification::Basic.notify_by_key [user], 'confirm_email'
    end
    it { subject.trigger_type.should == nil }
    it { subject.trigger_id.should == nil }
    it { subject.name.should =~ /email/ }
    it { subject.content.should =~ /email/ }
    it { subject.read.should be_false }
    it { subject.read_at.should be_nil }
  end
end

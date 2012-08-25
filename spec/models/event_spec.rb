require 'spec_helper'

describe Event do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }
  let(:master) { Level.find 1 }

  describe "after create" do
    subject { event }
    it { subject.attendences.should have(1).items }
    it { subject.attendences[0].level.id.should == master.id }
  end
end

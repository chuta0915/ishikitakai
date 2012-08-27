require 'spec_helper'

describe Wiki do
  let(:user) { FactoryGirl.create :user }
  let(:sendagayarb) { FactoryGirl.create :sendagayarb, :user_id => FactoryGirl.create(:user).id }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }
  describe 'Group wiki' do
    describe 'create wiki' do
      subject { sendagayarb }
      before do
        subject.wikis.build content: 'wiki content'
      end
      it { subject.should be_valid }
      it { subject.wikis[0].parent_type.should == 'Group' }
    end
  end

  describe 'Event wiki' do
    describe 'create wiki' do
      subject { event }
      before do
        subject.wikis.build content: 'wiki content'
      end
      it { subject.should be_valid }
      it { subject.wikis[0].parent_type.should == 'Event' }
    end
  end
end

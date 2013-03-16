require 'spec_helper'

describe Wiki do
  let(:user) { create :user }
  let(:sendagayarb) { create :sendagayarb, user_id: create(:user).id }
  let(:event) { create :mokmok_event, user: user }
  describe 'Group wiki' do
    describe 'create wiki' do
      context 'first' do
        subject { sendagayarb }
        before do
          subject.wikis.create name: 'wiki name', content: 'wiki content'
        end
        it { subject.should be_persisted }
        it { subject.wikis[0].parent_type.should == 'Group' }
        it { subject.wikis[0].versions.should have(1).items }
      end
      context 'second' do
        subject { sendagayarb }
        before do
          subject.wikis.create name: 'wiki name', content: 'wiki content1'
          wiki = subject.wikis[0]
          wiki.content = 'wiki content2'
          wiki.save
        end
        it { subject.wikis[0].versions.should have(2).items }
      end
    end
  end

  describe 'Event wiki' do
    describe 'create wiki' do
      context 'first' do
        subject { event }
        before do
          subject.wikis.create name: 'wiki name', content: 'wiki content'
        end
        it { subject.should be_persisted }
        it { subject.wikis[0].parent_type.should == 'Event' }
        it { subject.wikis[0].versions.should have(1).items }
      end
      context 'second' do
        subject { sendagayarb }
        before do
          subject.wikis.create name: 'wiki name', content: 'wiki content1'
          wiki = subject.wikis[0]
          wiki.content = 'wiki content2'
          wiki.save
        end
        it { subject.wikis[0].versions.should have(2).items }
      end
    end
  end
end

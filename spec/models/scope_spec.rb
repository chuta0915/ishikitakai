require 'spec_helper'

describe Scope do
  before do
    I18n.locale = :en
  end
  it 'scope has 5 scopes' do
    Scope.all.count.should == 5
  end
  describe 'label' do
    subject { Scope.find_by_name(name).label }
    context 'when public label' do
      let(:name) { 'public' }
      it { should == 'Public' }
    end
    context 'when friends label' do
      let(:name) { 'friends' }
      it { should == 'Friends' }
    end
    context "when friend's friends label" do
      let(:name) { 'friends_friends' }
      it { should == "Friend's Friends" }
    end
    context 'when closed label' do
      let(:name) { 'closed' }
      it { should == 'Closed' }
    end
    context 'when private label' do
      let(:name) { 'private' }
      it { should == 'Private' }
    end
  end
end

require 'spec_helper'

describe Level do
  before do
    I18n.locale = :en
  end
  it 'level has 4 records' do
    Level.all.count.should == 4
  end
  describe 'label' do
    subject { Level.find_by_name(name).label }
    context 'when master label' do
      let(:name) { 'master' }
      it { should == 'Master' }
    end
    context 'when support label' do
      let(:name) { 'support' }
      it { should == 'Staff' }
    end
    context 'when member label' do
      let(:name) { 'member' }
      it { should == 'Member' }
    end
    context 'when guest label' do
      let(:name) { 'guest' }
      it { should == 'Guest' }
    end
  end
end

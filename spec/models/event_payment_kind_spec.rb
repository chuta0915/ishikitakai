require 'spec_helper'

describe EventPaymentKind do
  before do
    I18n.locale = :en
  end
  it 'level has 3 providers' do
    EventPaymentKind.all.count.should == 3
  end
  describe 'label' do
    subject { EventPaymentKind.find_by_name(name).label }
    context 'when free label' do
      let(:name) { 'free' }
      it { should == 'Free' }
    end
    context 'when advance label' do
      let(:name) { 'advance' }
      it { should == 'Advance payment' }
    end
    context 'when deferred label' do
      let(:name) { 'deferred' }
      it { should == 'Deferred payment' }
    end
  end
end

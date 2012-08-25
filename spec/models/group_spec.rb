require 'spec_helper'

describe Group do
  ancestors_should_include [ActiveRecord::Base]
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, :user_id => FactoryGirl.create(:user).id }
  let!(:other_user) { FactoryGirl.create :new_user }
  let(:post) { FactoryGirl.create :post }

  describe 'group properties' do
    subject { sendagayarb }
    context 'when group created' do
      its(:name) { should be_present }
      its(:content) { should be_present }
    end
  end
  describe 'search scope' do
    subject { Group.search(keyword).first }
    context 'when passed "sendagaya"' do
      let(:keyword) { 'sendagaya' }
      its(:id) { should == sendagayarb.id }
    end
    context 'when passed "tokyo"' do
      let(:keyword) { 'tokyo' }
      it { should be_blank }
    end
  end

  describe 'user_can_edit?' do
    subject { sendagayarb }
    context "when group's master is current user" do
      it { subject.user_can_edit?(subject.user_id).should be_true }
    end
  end

  describe 'user_is_member?' do
    subject { sendagayarb }
    context "when other user is not member" do
      it { subject.user_is_member?(other_user.id).should be_false }
    end
    context "when other user is member" do
      before do
        sendagayarb.join other_user.id
      end
      it { subject.user_is_member?(other_user.id).should be_true }
    end
    context "when other user leave" do
      before do
        sendagayarb.join other_user.id
        sendagayarb.leave other_user.id
      end
      it { subject.user_is_member?(other_user.id).should be_false }
    end
  end

  describe 'collection_select' do
    subject { Group.collection_select(sendagayarb.user_id) }
    it "should have 'no community'" do
      subject[0].name.should == I18n.t('group.records.none')
    end
    it "should have 'sendagaya.rb'" do
      subject[1].name.should == sendagayarb.name
    end
  end
end

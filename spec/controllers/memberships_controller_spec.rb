require 'spec_helper'

describe MembershipsController do
  let!(:user) { FactoryGirl.create(:user) }
  let(:invalid_user) { FactoryGirl.create :new_user }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, :user_id => user.id }
  let(:ishikitakai) { FactoryGirl.attributes_for :ishikitakai }

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', :id => sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        put 'update', :id => sendagayarb.id
      end
      it { should redirect_to group_path(sendagayarb) }
    end
  end
  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', :id => sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        delete 'destroy', :id => sendagayarb.id
      end
      it { should redirect_to group_path(sendagayarb.id) }
    end
  end
end

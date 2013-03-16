require 'spec_helper'

describe MembershipsController do
  let!(:user) { create(:user) }
  let(:invalid_user) { create :new_user }
  let!(:sendagayarb) { create :sendagayarb, user_id: user.id }
  let(:ishikitakai) { FactoryGirl.attributes_for :ishikitakai }

  describe "GET 'index'" do
    context "user not signed in" do
      subject { response }
      before { get 'index', group_id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'index', group_id: sendagayarb.id
      end
      it { should be_success }
    end
  end

  describe "POST 'create'" do
    context "user not signed in" do
      subject { response }
      before { post 'create', group_id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        post 'create', group_id: sendagayarb.id
      end
      it { should redirect_to group_path(sendagayarb) }
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before do
        put 'update', group_id: sendagayarb.id, id: sendagayarb.memberships.first
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        put 'update', group_id: sendagayarb.id, id: sendagayarb.memberships.first
      end
      it { should redirect_to group_memberships_path(sendagayarb) }
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        delete 'destroy', id: sendagayarb.id
      end
      it { should redirect_to group_path(sendagayarb.id) }
    end
  end
end

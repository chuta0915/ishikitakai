require 'spec_helper'

describe KptsController do
  include KptHelper
  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create :other_user }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
  let!(:closed) { FactoryGirl.create :sendagayarb, user_id: other_user.id }
  let!(:kpt) { FactoryGirl.create :kpt, group_id: sendagayarb.id }
  let!(:new_kpt) { FactoryGirl.attributes_for :kpt }

  describe "GET 'index'" do
    context "user not signed in" do
    end

    context "user signed in" do
      context "public group" do
        subject { response }
        before do
          sign_in user
          get 'index', group_id: sendagayarb.id
        end
        it { should be_success }
      end
      context "non public group" do
        subject { response }
        before do
          sign_in user
          get 'index', group_id: closed.id
        end
        it { should render_template('groups/navigate') }
      end
    end
  end

  describe "POST 'create'" do
    context "user not signed in" do
      subject { response }
      before { post 'create', group_id: sendagayarb.id, kpt: new_kpt }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        context "public group" do
          subject { response }
          before do
            @created_kpt = FactoryGirl.create(:kpt, group_id: sendagayarb.id)
            Group.stub(:create).and_return(@created_kpt) 
            sign_in user
            post 'create', group_id: sendagayarb.id, kpt: new_kpt
          end
          it { should redirect_to kpts_path(sendagayarb) }
        end
        context "non public group" do
          subject { response }
          before do
            @created_kpt = FactoryGirl.create(:kpt, group_id: closed.id)
            Group.stub(:create).and_return(@created_kpt) 
            sign_in user
            post 'create', group_id: closed.id, kpt: new_kpt
          end
          it { should render_template('groups/navigate') }
        end
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          post 'create', group_id: sendagayarb.id
        end
        it { should redirect_to kpts_path(sendagayarb) }
        it { assigns(:kpt).errors.should be_present }
      end
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', group_id: sendagayarb.id, id: kpt.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "public group" do
        subject { response }
        before do
          sign_in user
          put 'update', group_id: sendagayarb.id, id: kpt.id, kpt: { status: Kpt::PROBLEM }
        end
        it { should redirect_to kpts_path(sendagayarb) }
      end
      context "non public group" do
        subject { response }
        before do
          sign_in user
          put 'update', group_id: closed.id, id: kpt.id, kpt: { status: Kpt::PROBLEM }
        end
        it { should render_template('groups/navigate') }
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', group_id: sendagayarb.id, id: kpt.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "public group" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', group_id: sendagayarb.id, id: kpt.id
        end
        it { should redirect_to kpts_path(sendagayarb) }
      end
      context "non public group" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', group_id: closed.id, id: kpt.id
        end
        it { should render_template('groups/navigate') }
      end
    end
  end
end

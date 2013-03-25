require 'spec_helper'

describe SettingsController do
  let(:user) { create(:user) }
  let(:user_setting) { FactoryGirl.attributes_for :user_setting }
  describe "GET 'show'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'show'
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'show'
      end
      it { should redirect_to edit_my_setting_path }
    end
  end

  describe "GET 'edit'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'edit'
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'edit'
      end
      it { should be_success }
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before do
        put 'update'
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        put 'update', {user_setting: user_setting }
      end
      it { should redirect_to edit_my_setting_path }
    end
  end
end

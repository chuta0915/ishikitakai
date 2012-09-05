require 'spec_helper'

describe EmailsController do
  let(:user) { FactoryGirl.create(:user) }
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
      it { should redirect_to edit_email_path }
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
        put 'update'
      end
      it { should redirect_to my_root_path }
    end
  end

  describe "GET 'confirmation'" do
    let(:hash) { '1e9de0fc008710a55431490febcf6208e827e324' }
    context "user not signed in" do
      subject { response }
      before do
        get 'confirmation', hash: hash
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "valid" do
        subject { response }
        before do
          sign_in user
          User.any_instance.stub(:confirm_email).and_return(true)
          get 'confirmation', hash: hash
        end
        it { should redirect_to my_root_path }
        it { flash[:notice].should be_present }
      end
      context "invalid" do
        subject { response }
        before do
          sign_in user
          User.any_instance.stub(:confirm_email).and_return(false)
          get 'confirmation', hash: hash
        end
        it { should redirect_to my_root_path }
        it { flash[:alert].should be_present }
      end
    end
  end
end

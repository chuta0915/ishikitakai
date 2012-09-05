require 'spec_helper'

describe NotificationsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:notification) { FactoryGirl.create(:notification_basic, user: user) }
  describe "GET 'index'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'index'
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "sync response" do
        subject { response }
        before do
          sign_in user
          get 'index'
        end
        it { should be_success }
        it { should render_template 'layouts/application' }
        it { should render_template :index }
      end
      context "async response" do
        subject { response }
        before do
          sign_in user
          xhr :get, 'index'
        end
        it { should be_success }
        it { should_not render_template 'layouts/application' }
        it { should render_template :index }
      end
    end
  end

  describe "GET 'show'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'show', id: notification.id
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'show', id: notification.id
      end
      it { should be_success }
    end
  end
end

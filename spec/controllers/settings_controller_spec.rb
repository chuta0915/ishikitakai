require 'spec_helper'

describe SettingsController do
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
      it { should be_success }
    end
  end
end

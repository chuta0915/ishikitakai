require "spec_helper"

describe UsersController do
  let!(:user) { FactoryGirl.create(:user) }
  
  describe "GET show" do
    context 'user not singed in' do
      before do
        get :show, id: user.id
      end
      it { response.response_code.should == 200 }
      it { response.should be_success }
    end
    context 'user signed in' do
      before do
        sign_in user
        get :show
      end
      it { response.response_code.should == 200 }
      it { response.should be_success }
    end
  end
  
  describe "DELETE destroy" do
    context 'user not singed in' do
      before do
        get :destroy
      end
      it { response.response_code.should == 302 }
      it { response.should redirect_to new_user_session_path }
    end
    context 'user singed in' do
      before do
        sign_in user
        get :destroy
      end
      it { response.response_code.should == 302 }
      it { response.should redirect_to root_path }
    end
  end
end

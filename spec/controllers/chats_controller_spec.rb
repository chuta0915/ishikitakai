require 'spec_helper'

describe ChatsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
  let(:chat) { FactoryGirl.create :chat, user_id: user.id, group_id: sendagayarb.id }
  
  describe "GET 'index'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'index', group_id: sendagayarb.id
      end
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

  describe "GET 'show'" do
    context "user not signed in" do
      subject { response }
      before do
        get 'show', group_id: sendagayarb.id, id: chat.id
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'show', group_id: sendagayarb.id, id: chat.id
      end
      it { should be_success }
    end
  end

  describe "POST 'create'" do
    context "user not signed in" do
      before do
        post 'create', group_id: sendagayarb.id, chat: {content: chat.content}
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        post 'create', group_id: sendagayarb.id, chat: {content: chat.content}
      end
      it { should redirect_to group_chats_path(sendagayarb.id) }
    end
  end
  
  describe "DELETE 'destroy'" do
    context "user not signed in" do
      before do
        delete 'destroy', group_id: sendagayarb.id, id: chat.id
      end
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        delete 'destroy', group_id: sendagayarb.id, id: chat.id
      end
      it { should redirect_to group_chats_path(sendagayarb.id) }
    end
  end
end

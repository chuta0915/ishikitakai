require 'spec_helper'

describe ChatsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
  let(:chat) { FactoryGirl.create :chat, user_id: user.id, group_id: sendagayarb.id }
  
  describe "GET 'index'" do
    subject { response }
    before { get 'index', group_id: sendagayarb.id }
    it { should be_success }
  end

  describe "GET 'show'" do
    subject { response }
    before { get 'show', group_id: sendagayarb.id, id: chat.id }
    it { should be_success }
  end

  describe "POST 'create'" do
    subject { response }
    before { post 'create', group_id: sendagayarb.id, chat: {content: chat.content} }
    it { should be_success }
  end
  
  describe "DELETE 'destroy'" do
    subject { response }
    before { delete 'destroy', group_id: sendagayarb.id, id: chat.id }
    it { should be_success }
  end
end

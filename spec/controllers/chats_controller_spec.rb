require 'spec_helper'

describe ChatsController do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, :user_id => user.id }
  describe "GET 'index'" do
    subject { response }
    before { get 'index', group_id: sendagayarb.id }
    it { should be_success }
  end
end

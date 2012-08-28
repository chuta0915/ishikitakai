require 'spec_helper'

describe WikisController do
  include WikiHelper
  let(:user) { FactoryGirl.create(:user) }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
  let!(:mokmok_event) { FactoryGirl.create :mokmok_event, user_id: user.id, group_id: sendagayarb.id }
  let(:wiki) { FactoryGirl.create(:wiki, user: user, parent: mokmok_event) }
  let(:new_wiki) { FactoryGirl.attributes_for(:wiki) }
  
  describe "GET index" do
    subject { response }
    before do
      get :index, event_id: mokmok_event.id
    end
    it { should be_success }
  end

  describe "GET show" do
    subject { response }
    before do
      get :show, event_id: mokmok_event.id, id: wiki.id
    end
    it { should be_success }
  end

  describe "GET new" do
    subject { response }
    context "user signed in" do
      before do
        sign_in user
        get :new, event_id: mokmok_event.id
      end
      it { should be_success }
    end
    context "user not signed in" do
      before do
        get :new, event_id: mokmok_event.id
      end
      it { subject.response_code.should == 302 }
      it { response.should redirect_to new_user_session_path }
    end
  end
  
  describe "GET edit" do
    subject { response }
    context "user signed in" do
      before do
        sign_in user
        get :edit, event_id: mokmok_event.id, id: wiki.id
      end
      it { should be_success }
    end
    context "user not signed in" do
      before do
        get :edit, event_id: mokmok_event.id, id: wiki.id
      end
      it { subject.response_code.should == 302 }
      it { response.should redirect_to new_user_session_path }
    end
  end

  describe "POST create" do
    subject { response }
    context "user signed in" do
      before do
        sign_in user
        post :create, event_id: mokmok_event.id, wiki: new_wiki
      end
      it { subject.response_code.should == 302 }
      it { should redirect_to wikis_path(mokmok_event) }
    end
    context "user not signed in" do
      before do
        post :create, event_id: mokmok_event.id
      end
      it { subject.response_code.should == 302 }
      it { response.should redirect_to new_user_session_path }
    end
  end

  describe "PUT update" do
    subject { response }
    context "user signed in" do
      before do
        sign_in user
        put :update, event_id: mokmok_event.id, id: wiki.id, wiki: new_wiki
      end
      it { subject.response_code.should == 302 }
      it { should redirect_to wiki_path(mokmok_event, wiki) }
    end
    context "user not signed in" do
      before do
        put :update, event_id: mokmok_event.id, id: wiki.id, wiki: new_wiki
      end
      it { subject.response_code.should == 302 }
      it { response.should redirect_to new_user_session_path }
    end
  end
end

require 'spec_helper'

describe CommentsController do
  let!(:user) { create(:user) }
  let(:invalid_user) { create :new_user }
  let!(:sendagayarb) { create :sendagayarb, user_id: user.id }
  let!(:mokmok_event) { create :mokmok_event, user_id: user.id, group_id: sendagayarb.id }
  let!(:comment) { create :comment, user: user, commentable: mokmok_event }
  let(:new_comment) { FactoryGirl.attributes_for:comment, user_id: user.id, commentable_type: 'Event', commentable_id: mokmok_event.id }

  describe "GET 'show'" do
    subject { response }
    before { get 'show', id: comment.id }
    it { should be_success }
  end

  describe "POST 'create'" do
    context "user not signed in" do
      subject { response }
      before { post 'create', event_id: mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          post 'create', event_id: mokmok_event.id, comment: new_comment
        end
        it { should redirect_to event_path(mokmok_event.id) }
        it { flash[:notice].should be_present }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          post 'create', event_id: mokmok_event.id
        end
        it { should redirect_to event_path(mokmok_event.id) }
        it { flash[:alert].should be_present }
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', id: comment.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', id: comment.id
        end
        it { should redirect_to event_path(mokmok_event.id) }
        it { flash[:notice].should be_present }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          user.id = invalid_user.id
          sign_in user
          delete 'destroy', id: comment.id
        end
        it { should be_not_found }
      end
    end
  end
end

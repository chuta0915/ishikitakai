require 'spec_helper'

describe AttendencesController do
  let!(:user) { FactoryGirl.create(:user) }
  let(:invalid_user) { FactoryGirl.create :new_user }
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: user.id }
  let!(:mokmok_event) { FactoryGirl.create :mokmok_event, user_id: user.id, group_id: sendagayarb.id }
  let(:reading_event) { FactoryGirl.attributes_for :reading_event }

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', id: mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        put 'update', id: mokmok_event.id
      end
      it { should redirect_to event_path(sendagayarb) }
    end
  end
  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', id: mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        delete 'destroy', id: sendagayarb.id
      end
      it { should redirect_to event_path(mokmok_event.id) }
    end
  end

end

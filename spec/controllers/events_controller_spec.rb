require 'spec_helper'

describe EventsController do
  let!(:user) { create(:user) }
  let(:invalid_user) { create :new_user }
  let!(:sendagayarb) { create :sendagayarb, user_id: user.id }
  let!(:mokmok_event) { create :mokmok_event, user_id: user.id, group_id: sendagayarb.id }
  let(:reading_event) { FactoryGirl.attributes_for :reading_event }

  describe "GET 'index'" do
    subject { response }
    context 'with no keyword' do
      before { get 'index' }
      it { should be_success }
    end
    context 'with "word" keyword' do
      before { get 'index', keyword: 'word' }
      it { should be_success }
      it { assigns[:events].should be_blank }
    end
    context 'with "mokmok" keyword' do
      before { get 'index', keyword: 'mokmok' }
      it { should be_success }
      it { assigns[:events].should be_present }
    end
  end

  describe "GET 'show'" do
    subject { response }
    before { get 'show', id: mokmok_event.id }
    it { should be_success }
  end

  describe "GET 'new'" do
    context "user not signed in" do
      subject { response }
      before { get 'new' }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'new'
      end
      it { should be_success }
    end
  end

  describe "POST 'create'" do
    context "user not signed in" do
      subject { response }
      before { post 'create' }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          @created_event = create(:reading_event, user_id:user.id)
          Event.stub(:create_by_user).and_return(@created_event)
          sign_in user
          post 'create', { event: reading_event }
        end
        it { should redirect_to event_path(@created_event.id) }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          post 'create'
        end
        it { should be_success }
        it { assigns(:event).errors.should be_present }
      end
    end
  end

  describe "GET 'edit'" do
    context "user not signed in" do
      subject { response }
      before { get 'edit', id: mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'edit', id: mokmok_event.id
      end
      it { should be_success }
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', :id => mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          put 'update', id: mokmok_event.id, event: {
            name: mokmok_event.name, content: mokmok_event.content}
        end
        it { should redirect_to event_path(mokmok_event.id) }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          put 'update', id: mokmok_event.id, event: { name: '' }
        end
        it { should be_success }
        it { assigns(:event).errors.should be_present }
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', id: mokmok_event.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', id: mokmok_event.id
        end
        it { should redirect_to events_path }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          user.id = invalid_user.id
          sign_in user
          delete 'destroy', id: sendagayarb.id
        end
        it { should be_not_found }
      end
    end
  end

  describe "GET 'copy'" do
    context "user not signed in" do
      subject { response }
      before { get 'copy', id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'copy', id: mokmok_event.id
      end
      it { should be_success }
      it { assigns[:event].name.should == mokmok_event.name }
      it { assigns[:event].summary.should == mokmok_event.summary }
      it { assigns[:event].group_id.should == mokmok_event.group_id }
      it { assigns[:event].place_address.should == mokmok_event.place_address }
      it { assigns[:event].place_map_url.should == mokmok_event.place_map_url }
      it { assigns[:event].place_name.should == mokmok_event.place_name }
      it { assigns[:event].place_url.should == mokmok_event.place_url }
    end
  end
end

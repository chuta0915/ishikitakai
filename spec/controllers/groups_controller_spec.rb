require 'spec_helper'

describe GroupsController do
  let!(:user) { create(:user) }
  let(:invalid_user) { create :new_user }
  let!(:sendagayarb) { create :sendagayarb, user_id: user.id }
  let!(:closed) { create :ishikitakai, user_id: user.id }
  let(:ishikitakai) { FactoryGirl.attributes_for :ishikitakai }

  describe "GET 'index'" do
    subject { response }
    context 'with no keyword' do
      before { get 'index' }
      it { should be_success }
    end
    context 'with "word" keyword' do
      before { get 'index', keyword: 'word' }
      it { should be_success }
      it { assigns[:groups].should be_blank }
    end
    context 'with "sendagaya" keyword' do
      before { get 'index', keyword: 'sendagaya' }
      it { should be_success }
      it { assigns[:groups].should be_present }
    end
  end

  describe "GET 'show'" do
    subject { response }
    context "public group" do
      before { get 'show', id: sendagayarb.id }
      it { should be_success }
      it { should render_template(:show) }
    end
    context "non public group" do
      context "not member" do
        before { get 'show', id: closed.id }
        it { should be_success }
        it { should render_template(:show_guest) }
      end
      context "member" do
        before do
          sign_in user
          get 'show', id: closed.id
        end
        it { should be_success }
        it { should render_template(:show) }
      end
    end
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
          @created_group = create(:ishikitakai, user_id:user.id)
          Group.stub(:create_by_user).and_return(@created_group)
          sign_in user
          post 'create', { group: ishikitakai }
        end
        it { should redirect_to group_path(@created_group.id) }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          post 'create'
        end
        it { should be_success }
        it { assigns(:group).errors.should be_present }
      end
    end
  end

  describe "GET 'edit'" do
    context "user not signed in" do
      subject { response }
      before { get 'edit', id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      subject { response }
      before do
        sign_in user
        get 'edit', id: sendagayarb.id
      end
      it { should be_success }
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          put 'update', id: sendagayarb.id, group: { name: sendagayarb.name, content: sendagayarb.content}
        end
        it { should redirect_to group_path(sendagayarb.id) }
      end
      context "with invalid parameters" do
        subject { response }
        before do
          sign_in user
          put 'update', id: sendagayarb.id, group: { name: '' }
        end
        it { should be_success }
        it { assigns(:group).errors.should be_present }
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', id: sendagayarb.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "with valid parameters" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', id: sendagayarb.id
        end
        it { should redirect_to groups_path }
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
end

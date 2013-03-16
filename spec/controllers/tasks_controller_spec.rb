require 'spec_helper'

describe TasksController do
  include TaskHelper
  let!(:user) { create(:user) }
  let!(:other_user) { create :other_user }
  let!(:sendagayarb) { create :sendagayarb, user_id: user.id }
  let!(:closed) { create :sendagayarb, user_id: other_user.id }
  let!(:task) { create :task, group_id: sendagayarb.id }
  let!(:new_task) { FactoryGirl.attributes_for :task }

  describe "GET 'index'" do
    context "user not signed in" do
    end

    context "user signed in" do
      subject { response }
      context "public group" do
        context 'with no keyword' do
          before do
            sign_in user
            get 'index', group_id: sendagayarb.id
          end
          it { should be_success }
        end
        context 'with "coffee" keyword' do
          before do
            sign_in user
            get 'index', group_id: sendagayarb.id, keyword: 'coffee'
          end
          it { should be_success }
          it { assigns[:tasks].should be_blank }
        end
        context 'with "milk" keyword' do
          before do
            sign_in user
            get 'index', group_id: sendagayarb.id, keyword: 'milk'
          end
          it { should be_success }
          it { assigns[:tasks].should be_present }
        end
      end
      context "non public group" do
          before do
            sign_in user
            get 'index', group_id: closed.id, keyword: 'coffee'
          end
          it { should render_template('groups/navigate') }
      end
    end
  end

  describe "POST 'create'" do
    context "user not signed in" do
      subject { response }
      before { post 'create', group_id: sendagayarb.id, task: new_task }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "public group" do
        context "with valid parameters" do
          subject { response }
          before do
            @created_task = create(:task)
            Group.stub(:create).and_return(@created_task)
            sign_in user
            post 'create', group_id: sendagayarb.id, task: new_task
          end
          it { should redirect_to tasks_path(sendagayarb) }
        end
        context "with invalid parameters" do
          subject { response }
          before do
            sign_in user
            post 'create', group_id: sendagayarb.id
          end
          it { should redirect_to tasks_path(sendagayarb) }
          it { assigns(:task).errors.should be_present }
        end
      end

      context "non public group" do
        subject { response }
        before do
          sign_in user
          post 'create', group_id: closed.id
        end
        it { should  }
      end
    end
  end

  describe "PUT 'update'" do
    context "user not signed in" do
      subject { response }
      before { put 'update', group_id: sendagayarb.id, id: task.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "public group" do
        subject { response }
        before do
          sign_in user
          put 'update', group_id: sendagayarb.id, id: task.id
        end
        it { should redirect_to tasks_path(sendagayarb) }
      end
      context "non public group" do
        subject { response }
        before do
          sign_in user
          put 'update', group_id: closed.id, id: task.id
        end
        it { should render_template('groups/navigate') }
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "user not signed in" do
      subject { response }
      before { delete 'destroy', group_id: sendagayarb.id, id: task.id }
      it { should redirect_to new_user_session_path }
    end
    context "user signed in" do
      context "public group" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', group_id: sendagayarb.id, id: task.id
        end
        it { should redirect_to tasks_path(sendagayarb) }
      end
      context "non public group" do
        subject { response }
        before do
          sign_in user
          delete 'destroy', group_id: closed.id, id: task.id
        end
        it { should render_template('groups/navigate') }
      end
    end
  end
end

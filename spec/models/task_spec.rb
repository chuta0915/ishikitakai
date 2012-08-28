require 'spec_helper'

describe Task do
  let!(:task) { FactoryGirl.create(:task) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:friend) { FactoryGirl.create(:friend) }
  describe 'change status done' do
    context 'no user' do
      context 'created' do
        it { task.done.should be_false }
      end
      context 'completed' do
        before do
          task.complete
        end
        it { task.done.should be_true }
      end
    end

    context 'specified user' do
      context 'created' do
        before do
          task.created_user = user
        end
        it { task.done.should be_false }
      end
      context 'completed' do
        before do
          task.complete
        end
        it { task.done.should be_true }
      end
    end
  end
end

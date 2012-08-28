require 'spec_helper'

describe Task do
  let!(:sendagayarb) { FactoryGirl.create :sendagayarb, user_id: FactoryGirl.create(:user).id }
  let!(:task) { FactoryGirl.create(:task, group_id: sendagayarb.id) }
  describe 'change status done' do
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
end

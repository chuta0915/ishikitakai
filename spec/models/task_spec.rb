require 'spec_helper'

describe Task do
  let!(:sendagayarb) { create :sendagayarb, user_id: create(:user).id }
  let!(:task) { create(:task, group_id: sendagayarb.id) }
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

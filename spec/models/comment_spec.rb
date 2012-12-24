require 'spec_helper'

describe Comment do
  ancestors_should_include ActiveRecord::Base
  let(:user) { FactoryGirl.create :user }
  let(:friend) { FactoryGirl.create :friend }
  let(:event) { FactoryGirl.create :mokmok_event, user: user }

  describe 'notify' do
    context 'when posted comment to event' do
      before do
        ActionMailer::Base.deliveries = []
        event.join friend.id
        event.comments.create(content: 'comment', user_id: user.id)
      end
      it { friend.notifications.should have(1).items }
      it { friend.notifications[0].type.should == 'Notification::EventComment' }
      it { ActionMailer::Base.deliveries.size.should == 1 }
    end
  end
end

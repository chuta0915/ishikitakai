class Comment < ActiveRecord::Base
  include Common::Markdown
  attr_accessible :commentable_id, :commentable_type, :commentable, :content, :user_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  validates_presence_of :content
  after_create :notify_event_comment

  def user_is_owner? user
    self.user_id == user.try(:id)
  end

  private
  def notify_event_comment
    if self.commentable.instance_of?(Event)
      ::Notification::EventComment.notify(self.commentable.try(:users), self.commentable)
    end
  end
end

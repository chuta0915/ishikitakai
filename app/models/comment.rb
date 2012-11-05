class Comment < ActiveRecord::Base
  include Common::Markdown
  attr_accessible :commentable_id, :commentable_type, :commentable, :content, :user_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  validates_presence_of :content

  def user_is_owner? user_id
    self.user_id == user_id
  end
end
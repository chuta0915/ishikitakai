class Wiki < ActiveRecord::Base
  include Common::Markdown
  include Common::UserCreation
  has_paper_trail
  attr_accessible :content, :name, :parent_id, :parent_type, :user_id
  belongs_to :parent, :polymorphic => true
  belongs_to :user

  validates_presence_of :name, :content
  validates_length_of :name, :minimum => 0, :maximum => 100
  validates_length_of :content, :minimum => 0, :maximum => 30000
end

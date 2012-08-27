class Wiki < ActiveRecord::Base
  include Common::Markdown
  has_paper_trail
  attr_accessible :content, :name, :parent_id, :parent_type, :user_id
  belongs_to :parent, :polymorphic => true
end

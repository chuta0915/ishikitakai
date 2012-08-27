class Wiki < ActiveRecord::Base
  include Common::Markdown
  attr_accessible :content, :name, :parent_id, :parent_type, :user_id
  belongs_to :parent, :polymorphic => true
end

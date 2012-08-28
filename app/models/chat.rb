class Chat < ActiveRecord::Base
  attr_accessible :content, :group_id, :user_id
  belongs_to :group
  belongs_to :user
  validates_presence_of :content
  validates_length_of :content, minimum: 0, maximum: 500

  def content
    c = super
    c = '' if c.nil?
    c.to_md
  end
end

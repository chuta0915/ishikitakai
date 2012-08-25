class Membership < ActiveRecord::Base
  attr_accessible :user_id, :level_id
  belongs_to :user
  belongs_to :group
  belongs_to :level
end

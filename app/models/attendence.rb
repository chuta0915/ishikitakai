class Attendence < ActiveRecord::Base
  attr_accessible :content, :event_id, :level_id, :user_id
  belongs_to :event
  belongs_to :user
  belongs_to :level
end

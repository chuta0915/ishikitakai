class UserSetting < ActiveRecord::Base
  attr_accessible :mail_attend_status, :mail_event_comment, :user_id
end

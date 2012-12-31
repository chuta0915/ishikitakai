class UserSetting < ActiveRecord::Base
  attr_accessible :mail_attend_status, :mail_event_comment, :mail_event_attendance, :user_id
end

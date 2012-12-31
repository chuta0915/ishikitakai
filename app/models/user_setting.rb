class UserSetting < ActiveRecord::Base
  attr_accessible :mail_attend_status, :mail_event_comment, :mail_event_attendance,
   :mail_group_event, :user_id
end

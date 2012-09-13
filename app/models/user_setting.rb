class UserSetting < ActiveRecord::Base
  attr_accessible :mail_attend_status, :user_id
end
